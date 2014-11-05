#!/usr/bin/env ruby
#---
# Excerpted from "Build Awesome Command-Line Applications in Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dccar2 for more book information.
#---

require 'open3'
require 'yaml'

require 'main'

Main { 
  # declare options and arguments

  CONFIG_FILE = File.join(ENV['HOME'],'.db_backup.rc.yaml')

  options = {
    :gzip => true,
    :force => false,
    :'end-of-iteration' => false,
    :username => nil,
    :password => nil,
  }

  if File.exists? CONFIG_FILE
    options_config = YAML.load_file(CONFIG_FILE)
    options.merge!(options_config)
  else
    File.open(CONFIG_FILE,'w') { |file| YAML::dump(options,file) }
    STDERR.puts "Initialized configuration file in #{CONFIG_FILE}"
  end

  executable_name = File.basename($PROGRAM_NAME)
  synopsis "#{executable_name} [options] database_name
  
Backup one or more MySQL databases" 

  option('username') {
    description 'Database username, in first.last format'
    argument :required
    default options[:username]
    validate do |arg| 
      arg =~ /^[^\.]+\.[^\.]+$/ 
      if !arg
        arg =~ /root/
      else
        arg
      end
    end
  }

  option('password') {
    description 'Database password'
    argument :required
    default options[:password]
  }

  option('end-of-iteration') { 
    description 'Mark this as an "end-of-iteration" backup'
    default options[:'end-of-iteration']
  }

  option('gzip') {
    description 'compress the backup'
    default true
    default options[:gzip]
  }

  option('no-gzip') {
    description 'Do not compress the backup'
    default false
  }

  option('force') {
    description 'overwrite existing backup'
    default true
    default options[:force]
  }
  argument('database_name') { 
    description 'database to backup'
    argument :required
  }

  run { 
    auth = ""
    auth += "-u#{params['username'].value} " if params['username'].value 
    auth += "-p#{params['password'].value} " if params['password'].value

    database_name = params['database_name'].value 

    # rest of the main logic...
    now = Time.now
    output_file = sprintf("%s-%4d-%02d-%02d.sql",
                          database_name,now.year,now.month,now.day)

    command = "mysqldump #{auth}#{database_name} > #{output_file}"

    if File.exists? output_file
      if params['force'].value
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
    run("gzip #{output_file}",4) unless params['no-gzip'].value
    end
  }
}
