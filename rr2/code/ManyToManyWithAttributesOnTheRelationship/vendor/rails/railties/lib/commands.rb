#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
commands = Dir["#{File.dirname(__FILE__)}/commands/*.rb"].collect { |file_path| File.basename(file_path).split(".").first }

if commands.include?(ARGV.first)
  require "#{File.dirname(__FILE__)}/commands/#{ARGV.shift}"
else
  puts <<-USAGE
The 'run' provides a unified access point for all the default Rails' commands.
  
Usage: ./script/run <command> [OPTIONS]

Examples:
  ./script/run generate controller Admin
  ./script/run process reaper

USAGE
  puts "Choose: #{commands.join(", ")}"
end