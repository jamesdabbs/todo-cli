require "pry"

command = ARGV.shift

case command
when "lists"
  puts "Users wants to see all lists"
when "show"
  name = ARGV.first
  puts "Users wants to see one list, namely #{name}"
else
  puts "I don't know how to `#{command}`"
end
