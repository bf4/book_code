#---
# Excerpted from "Web Design for Developers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/bhgwad for more book information.
#---
# Scans your project for CSS and JS files and 
# runs them through the Yahoo Compression utility
# and then uploads the entire site to your web server via SCP.

# Configure your settings below and be sure to supply the proper path
# to the Yahoo compressor. Set the COMPRESS flag to false to skip compression

COMPRESS = true
WORKING_DIR = "working"
REMOTE_USER = "homer"
REMOTE_HOST = "yourfoodbox.com"
REMOTE_PORT = 22

REMOTE_DIR = "/home/#{REMOTE_USER}/yourfoodbox.com/"

FILES = ["index.html",
         ".htaccess",
         "global_append.php",
         "global_prepend.php",
         "favicon.ico",
         "stylesheets",
         "images"
        ]

COMPRESSOR_CMD = 'java -jar bin/yuicompressor-2.4.2.jar'
# DONE CONFIGURING

require 'rubygems'
require 'net/scp'
require 'fileutils'

@errors = [] 

FileUtils.rm_rf WORKING_DIR
FileUtils.mkdir WORKING_DIR
FILES.each do |f|
  if File.directory?(f)
    FileUtils.cp_r f, WORKING_DIR
  else
    FileUtils.cp f, WORKING_DIR
  end
end

# Upload files in our working directory to the server
def upload(files)
  Net::SCP.start(REMOTE_HOST, REMOTE_USER, :port => REMOTE_PORT) do |scp|
   files.each do |file|
     puts "uploading #{file}"
     if File.directory?(file)
       scp.upload! "working/#{file}",  REMOTE_DIR, :recursive => true
     else       
       scp.upload! "working/#{file}",  REMOTE_DIR
     end
   end
 end
end


# Minify all CSS and JS files found within the working
# directory
def minify(working_dir)
  files = Dir.glob("#{working_dir}/**/*.{css, js}")
  
  files.each do |file|
    type = File.extname(file) == ".css" ? "css" : "js"
    newfile = file.gsub(".#{type}", ".new.#{type}")
    puts "minifying #{file}"
    `#{COMPRESSOR_CMD} --type #{type} #{file} > #{newfile}`

    if File.size(newfile) > 0
      FileUtils.cp newfile, file
    else
      @errors << "Unable to process #{file}."
    end
  
  end
end
  
minify(WORKING_DIR) if COMPRESS

if @errors.length == 0
  puts "Deploying"
  upload(FILES)
else
  puts "Unable to deploy."
  @errors.each{|e| puts e}
end
