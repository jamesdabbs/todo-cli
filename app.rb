require "pry"
require "sinatra/base"
require "sinatra/json"

require "./db/setup"
require "./lib/all"

class TodoApp < Sinatra::Base
  set :logging, true
  set :show_exceptions, false

  error do |e|
    if e.is_a? ActiveRecord::RecordNotFound
      halt 404, json(error: "Not Found")
    elsif e.is_a? ActiveRecord::RecordInvalid
      halt 422, json(error: e.message)
    else
      # raise e
      puts e.message
    end
  end

  get "/lists" do
    json lists: user.lists.pluck(:title)
  end

  get "/lists/:name" do
    list = user.lists.where(title: params[:name]).first
    json items: list.items
  end

  post "/lists/:name" do
    List.create!
    list = user.lists.where(title: params[:name]).first
    list.add_item parsed_body["name"], due_date: parsed_body["due_date"]

    status 200
  end

  delete "/items/:id" do
    item = user.items.find params[:id]
    item.mark_complete
    status 200
  end

  get "/message/:text" do
    params[:text].reverse
  end

  post "/lists" do
    user.make_list params[:title]
  end

  def user
    username = request.env["HTTP_AUTHORIZATION"]
    halt 401 unless username
    User.find_by(username: username) || halt(403)
  end

  def parsed_body
    begin
      @parsed_body ||= JSON.parse request.body.read
    rescue JSON::ParserError
      halt 400
    end
  end
end

if $PROGRAM_NAME == __FILE__
  TodoApp.run!
end
