#!/usr/bin/env ruby
#---
# Excerpted from "Build Awesome Command-Line Applications in Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dccar2 for more book information.
#---

require 'optparse'
require 'open3'

options = {}
option_parser = OptionParser.new do |opts|
  executable_name = File.basename($PROGRAM_NAME)
  opts.banner = "Usage: #{executable_name} [options] database_name"

  opts.banner= <<-EOS
Backup one or more MySQL databases

Usage: #{executable_name} [options] database_name

  EOS

  opts.on("-i","--iteration",
          'Indicate that this backup is an "iteration" backup') do 
    options[:iteration] = true
  end
  opts.on("-u USER",
          "Database username, in first.last format") do |user|
    options[:user] = user
  end

  opts.on("-p PASSWORD",
         "Database password") do |password|
    options[:password] = password
  end
end

begin
  option_parser.parse!
  if ARGV.empty?
    puts "error: you must supply a database name"
    puts
    puts option_parser.help
    exit -2
  end
rescue OptionParser::InvalidArgument => ex
  STDERR.puts ex.message
  STDERR.puts option_parser
  exit -1
end

auth = ""
auth += "-u#{options[:user]} " if options[:user]
auth += "-p#{options[:password]} " if options[:password]

database_name = ARGV[0]
output_file = "#{database_name}.sql"

command = "/usr/local/mysql/bin/mysqldump #{auth}#{database_name} > #{output_file}"

if ENV['NO_RUN']
  def system(cmd)
    puts cmd
    true
  end
end
if false
system(command)
end

puts "Running '#{command}'"
stdout_str, stderr_str, status = Open3.capture3(command)

unless status.exitstatus == 0
  puts "There was a problem running '#{command}'"
  puts stderr_str
  exit -1
end
