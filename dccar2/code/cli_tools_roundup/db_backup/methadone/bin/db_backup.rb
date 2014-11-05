#!/usr/bin/env ruby
#---
# Excerpted from "Build Awesome Command-Line Applications in Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dccar2 for more book information.
#---

require 'methadone'
require 'open3'
require 'yaml'

include Methadone::Main 

main do |database_name| 
  
  # main logic of the app...

  auth = ""
  auth += "-u#{options[:username]} " if options[:username]
  auth += "-p#{options[:password]} " if options[:password]

  now = Time.now
  output_file = sprintf("%s-%4d-%02d-%02d.sql",
                        database_name,now.year,now.month,now.day)

  command = "mysqldump #{auth}#{database_name} > #{output_file}"

  if File.exists? output_file
    if options[:force] 
      warn "Overwriting #{output_file}"
    else
      exit_now!(1,"error: #{output_file} exists, use --force to overwrite")
    end
  end

  unless ENV['NO_RUN']
  run(command,3)
  run("gzip #{output_file}",4) if options[:gzip]
  end
end

# define any helper methods here...


def run(command,exit_on_error_with)
  info "Running '#{command}'"
  stdout_str, stderr_str, status = Open3.capture3(command)

  info stdout_str
  unless status.success?
    error stderr_str
    exit_now!(exit_on_error_with, "There was a problem running '#{command}'")
  end
end

options[:gzip]               = true
options[:force]              = false
options[:'end-of-iteration'] = false
options[:username]           = nil
options[:password]           = nil

CONFIG_FILE = File.join(ENV['HOME'],'.db_backup.rc.yaml')

if File.exists? CONFIG_FILE
  options_config = YAML.load_file(CONFIG_FILE)
  options_config.each do |key,val|
    options[key] = val
  end
  
else
  File.open(CONFIG_FILE,'w') { |file| YAML::dump(options,file) }
  warn "Initialized configuration file in #{CONFIG_FILE}"
end

# now declare user interface

description "Backup one or more MySQL databases" 


on('-i','--end-of-iteration',
   'Indicate that this backup is an "iteration" backup')

on('-u USER','--username','Database username, in first.last format')

on("-p PASSWORD", "--password", "Database password")
on("--[no-]gzip","Do not compress the backup file")
on("--[no-]force","Overwrite existing files")

arg :database_name, :required, :many 
# declare user interface here

go! 
