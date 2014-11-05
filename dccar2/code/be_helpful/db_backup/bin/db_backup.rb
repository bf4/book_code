#!/usr/bin/env ruby
#---
# Excerpted from "Build Awesome Command-Line Applications in Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dccar2 for more book information.
#---
#!/usr/bin/env ruby

require 'optparse'

options = {}
option_parser = OptionParser.new do |opts|
  executable_name = File.basename($PROGRAM_NAME)
  opts.banner = "Usage: #{executable_name} [options] database_name"

  executable_name = File.basename($PROGRAM_NAME)
  opts.banner = "Backup one or more MySQL databases

Usage: #{executable_name} [options] database_name

"

  opts.on('-i','--iteration',
          'Indicate that this backup is an "iteration" backup') do 
    options[:iteration] = true
  end
  opts.on('-u USER',
          'Database username, in first.last format',
          /^[^.]+\.[^.]+$/) do |user|
    options[:user] = user
  end

  opts.on('-p PASSWORD',
         'Database password') do |password|
    options[:password] = password
  end
end

begin
  option_parser.parse!
  if ARGV.empty?
    puts "error: you must supply a database_name"
    puts
    puts option_parser.help
    exit 1
  else
    database_name = ARGV[0]
    # proceed as normal to backup database_name
  end
rescue OptionParser::InvalidArgument => ex
  STDERR.puts ex.message
  STDERR.puts option_parser
end

if ARGV.include? 'DEBUG'
  puts "iteration: #{options[:iteration]}"
  puts "user: #{options[:user]}"
  puts "password: #{options[:password]}"
  ARGV.each do |database|
    puts database unless database == 'DEBUG'
  end
end
