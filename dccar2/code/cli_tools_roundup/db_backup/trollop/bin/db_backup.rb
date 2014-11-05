#!/usr/bin/env ruby
#---
# Excerpted from "Build Awesome Command-Line Applications in Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dccar2 for more book information.
#---

require 'trollop'
require 'open3'

require 'yaml'

CONFIG_FILE = File.join(ENV['HOME'],'.db_backup.rc.yaml')

defaults = { 
  :gzip               => true,
  :force              => false,
  :'end-of-iteration' => false,
  :username           => nil,
  :password           => nil,
}

if File.exists? CONFIG_FILE
  options_config = YAML.load_file(CONFIG_FILE)
  defaults.merge!(options_config)
else
  File.open(CONFIG_FILE,'w') { |file| YAML::dump(options,file) }
  STDERR.puts "Initialized configuration file in #{CONFIG_FILE}"
end

parser = Trollop::Parser.new do

  # declare UI...

  executable_name = File.basename($PROGRAM_NAME)
  banner("Backup one or more MySQL databases")
  banner("")
  banner("Usage: #{executable_name} [options] database_name")
  banner("")
  banner("Options:")

  opt :username, "Database username, in first.last format", type: :string
  opt :password, "Database password", type: :string

  opt :i, 'Indicate that this backup is an "iteration" backup',
    long: 'end-of-iteration'

  opt 'no-gzip',"Do not compress the backup file", default: false
  opt :gzip,"Compress the backup file", default: true
  conflicts(:gzip,'no-gzip')

  opt :force, "Overwrite existing files"
end

options = Trollop::with_standard_exception_handling(parser) do
  o = parser.parse(ARGV)
  defaults.each do |key,val|
    o[key] = val if o[key].nil?
  end
  if ARGV.empty?
    STDERR.puts "error: you must supply a database name"
    raise Trollop::HelpNeeded
  end
  o
end


auth = ""
auth += "-u#{options[:username]} " if options[:username]
auth += "-p#{options[:password]} " if options[:password]

database_name = ARGV[0]

now = Time.now
output_file = sprintf("%s-%4d-%02d-%02d.sql",
                      database_name,now.year,now.month,now.day)

command = "mysqldump #{auth}#{database_name} > #{output_file}"

if File.exists? output_file
  if options[:force]
    STDERR.puts "Overwriting #{output_file}"
  else
    STDERR.puts "error: #{output_file} exists, use --force to overwrite"
    exit 1
  end
end

def run(command,exit_on_error_with)
  puts "Running '#{command}'"
  stdout_str, stderr_str, status = Open3.capture3(command)

  puts stdout_str
  unless status.success?
    STDERR.puts "There was a problem running '#{command}'"
    STDERR.puts stderr_str
    exit exit_on_error_with
  end
end

unless ENV['NO_RUN']
  run(command,3)
  run("gzip #{output_file}",4) unless options['no-gzip']
end

