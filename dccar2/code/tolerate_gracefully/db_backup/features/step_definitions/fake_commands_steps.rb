#---
# Excerpted from "Build Awesome Command-Line Applications in Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dccar2 for more book information.
#---
Given /^we're faking things out$/ do
  @original_path = ENV['PATH']
  ENV['PATH'] = "#{File.join(File.expand_path(File.dirname(__FILE__)),'fake_bin')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"
  %w(mysqldump gzip).each do |app|
    rm_rf "/tmp/#{app}_called" if File.exists? "/tmp/#{app}_called"
  end
end

Then /^db_backup\.rb should've executed "([^"]*)"$/ do |app|
  step %(a file named "/tmp/#{app}_called" should exist)
end

Then /^db_backup\.rb should NOT have executed "([^"]*)"$/ do |app|
  step %(a file named "/tmp/#{app}_called" should not exist)
end


