#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'rubygems'
require 'jmx'

client  = JMX.connect :port => 9999
counter = client['DefaultDomain:type=HitBean']

loop do
  puts "The hit counter is at #{counter.hits.value}"
  puts "Type R to reset, or press Enter to continue"

  counter.clear if gets.strip.upcase == 'R'
end
