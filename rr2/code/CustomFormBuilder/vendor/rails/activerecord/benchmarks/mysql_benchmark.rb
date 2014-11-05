#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'mysql'

conn = Mysql::real_connect("localhost", "root", "", "basecamp")

require 'benchmark'

require 'profile' if ARGV[1] == "profile"
RUNS = ARGV[0].to_i

runtime = Benchmark::measure {
  RUNS.times { 
    result = conn.query("SELECT * FROM posts LIMIT 100")
    result.each_hash { |p| p["title"] }
  }
}

puts "Runs: #{RUNS}"
puts "Avg. runtime: #{runtime.real / RUNS}"
puts "Requests/second: #{RUNS / runtime.real}"