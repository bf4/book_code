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

require 'yaml'
options = {
  :gzip  => true,
  :force => false,
}
CONFIG_FILE = File.join(ENV['HOME'],'.db_backup.rc.yaml')
if File.exists? CONFIG_FILE
  config_options = YAML.load_file(CONFIG_FILE)
  options.merge!(config_options)
end
options = {
  :gzip               => true,
  :force              => false,
  :'end-of-iteration' => false,
  :username           => nil,
  :password           => nil,
}

if File.exists? CONFIG_FILE
  options_config = YAML.load_file(CONFIG_FILE)
  options.merge!(options_config)
else
  File.open(CONFIG_FILE,'w') { |file| YAML::dump(options,file) }
  STDERR.puts "Initialized configuration file in #{CONFIG_FILE}"
end


option_parser = OptionParser.new do |opts|
  # ...
  executable_name = File.basename($PROGRAM_NAME)
  opts.banner = "Usage: #{executable_name} [options] database_name"

  opts.banner= <<-EOS
Backup one or more MySQL databases

Usage: #{executable_name} [options] database_name

  EOS

  opts.on("-i",
          "--end-of-iteration",
          'Indicate that this backup is an "iteration" backup') do 
    options[:'end-of-iteration'] = true
  end
  opts.on("-u USER",
          "--username",
          "Database username, in first.last format") do |user|
    options[:username] = user
  end

  opts.on("-p PASSWORD",
          "--password",
         "Database password") do |password|
    options[:password] = password
  end

  opts.on("--help","Show complete help on command-line options") do
    puts opts.to_s
    exit 0
  end

  simple_help = opts.to_s

  opts.on("-h","Show brief help") do 
    puts simple_help
    exit 0
  end

  opts.on("--no-gzip","Do not compress the backup file") do
    options[:gzip] = false
  end
  opts.on("--[no-]force","Overwrite existing files") do |force|
    options[:force] = force
  end
end

begin
  option_parser.parse!
  if ARGV.empty?
    puts "error: you must supply a database name"
    puts
    puts option_parser.help
    exit 2
  end
rescue OptionParser::InvalidArgument => ex
  STDERR.puts ex.message
  STDERR.puts option_parser
  exit 1
end

auth = ""
auth += "-u#{options[:username]} " if options[:username]
auth += "-p#{options[:password]} " if options[:password]

database_name = ARGV[0]
output_file = "#{database_name}.sql"

command = "/usr/local/mysql/bin/mysqldump #{auth}#{database_name} > #{output_file}"

if File.exists? output_file
  if options[:force]
    STDERR.puts "Overwriting #{output_file}"
  else
    STDERR.puts "error: #{output_file} exists, use --force to overwrite"
    exit 1
  end
end

unless ENV['NO_RUN']
  puts "Running '#{command}'"
  stdout_str, stderr_str, status = Open3.capture3(command)

  unless status.success?
    STDERR.puts "There was a problem running '#{command}'"
    STDERR.puts stderr_str.gsub(/^mysqldump: /,'')
    exit 1
  end
end


