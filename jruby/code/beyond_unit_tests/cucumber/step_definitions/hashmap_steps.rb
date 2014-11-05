#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'java'
require 'rubygems'

java_import java.util.HashMap

$maps = { }

Given /^my (.*) contains "(.*)" with value "(.*)"$/ do |map_name, key, value|
  $maps[map_name] ||= HashMap.new
  $maps[map_name][key] = value
end

Given /^my (.*) is empty$/ do |map_name|
  $maps[map_name] ||= HashMap.new
  $maps[map_name].clear
end

When /^I transfer "(.*)" from my (.*) to my (.*)$/ do |key, from_map, to_map|
  $maps[to_map][key] = $maps[from_map][key]
  $maps[from_map].remove(key)
end

Then /^my (.*) should contain "(.*)" with value "(.*)"$/ do |map_name, key, value|
  $maps[map_name][key].should == value
end

Then /^my (.*) should not contain "(.*)"$/ do |map_name, key|
  $maps[map_name].contains_key(key).should_not be_true
end

Then /^my (.*) should be empty$/ do |map_name|
  $maps[map_name].should be_empty
end
