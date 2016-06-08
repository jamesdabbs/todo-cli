require "pry"
require "sinatra/base"
require "sinatra/json"

require "./db/setup"
require "./lib/all"

class TodoApp < Sinatra::Base
  set :logging, true
  set :show_exceptions, false

  error do |e|
    #binding.pry
    raise e
  end

  get "/lists" do
    lists = user.lists
    resp = { lists: user.lists.pluck(:title) }
    json resp
  end

  # get "/lists/:name"
  #
  # post "/lists/:name"
  #
  # delete "/items/:id"

  def user
    username = request.env["HTTP_AUTHORIZATION"]
    if username
      # FIXME: what if this is a new user? We don't have a password
      User.where(username: username).first_or_create!
    else
      halt 401
    end
  end
end

TodoApp.run!
