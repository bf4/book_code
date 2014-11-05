#---
# Excerpted from "Build Awesome Command-Line Applications in Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dccar2 for more book information.
#---
require 'open3'
MYSQL    = ENV['DB_BACKUP_MYSQL'] || '/usr/local/mysql/bin/mysql'
USER     = ENV['DB_BACKUP_USER'] || 'root'

Given /^the database backup_test exists$/ do
  test_sql_file  = File.join(File.dirname(__FILE__),'..','..','setup_test.sql')
  command = "#{MYSQL} -u#{USER} < #{test_sql_file}"
  stdout,stderr,status = Open3.capture3(command)
  unless status.success?
    raise "Problem running #{command}, stderr was:\n#{stderr}"
  end
end


def expected_filename
  now = Time.now
  sprintf("backup_test-%4d-%02d-%02d.sql",now.year,now.month,now.day)
end

Then /^the backup file should be gzipped$/ do
  Then %(a file named "#{expected_filename}.gz" should exist)
end

Then /^the backup file should NOT be gzipped$/ do
  now = Time.now
  Then %(a file named "#{expected_filename}" should exist)
end
