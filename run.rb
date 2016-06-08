require "pry"
require "./db/setup"
require "./lib/all"

command = ARGV.shift
username = `git config user.name`.chomp
puts "Welcome back, #{username}"

case command
when "lists"
  user  = User.find_by username: username
  lists = user.lists
  # FIXME: n+1
  lists.each do |list|
    puts "* #{list.title} [#{list.items.count}]"
  end
when "show"
  name = ARGV.first
  puts "Users wants to see one list, namely #{name}"
else
  puts "I don't know how to `#{command}`"
end
