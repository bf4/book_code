#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
$:.unshift(File.dirname(__FILE__) + '/../lib')
if ARGV[2]
  require 'rubygems'
  require_gem 'activerecord', ARGV[2]
else
  require 'active_record'
end

ActiveRecord::Base.establish_connection(:adapter => "mysql", :database => "basecamp")

class Post < ActiveRecord::Base; end

require 'benchmark'

RUNS = ARGV[0].to_i
if ARGV[1] == "profile" then require 'profile' end

runtime = Benchmark::measure {
  RUNS.times { 
    Post.find_all(nil,nil,100).each { |p| p.title }
  }
}

puts "Runs: #{RUNS}"
puts "Avg. runtime: #{runtime.real / RUNS}"
puts "Requests/second: #{RUNS / runtime.real}"
