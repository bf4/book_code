#---
# Excerpted from "Ruby Performance Optimization",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/adrpo for more book information.
#---
require 'wrapper'

class Bugger
end

data = Array.new(100000) { Bugger.new }

puts ObjectSpace.each_object(Bugger).count

def do_something(&block)
  yield
  puts ObjectSpace.each_object(Bugger).count
end

puts "-------"
do_something { data[1] = "blah"; puts data[1] }
puts ">>>>>>>"
do_something { puts data[1] }



# class Bugger
# 
#   attr_accessor :x
# 
#   def self.do_something_later(&block)
# #     @@actions ||= []
# #     @@actions << block
#     block.call
#   end
# 
#   def initialize
#     self.x = "x" * 1024 * 1024
#     Bugger.do_something_later { self.x }
#   end
# 
# end
# 
# measure do
#   1000.times { Bugger.new }
# end
# 
# p ObjectSpace.each_object(Bugger).count #=> 1000


# class Environment
#   def initialize
#     @data = "x"*600
#   end
# end
# environment = Array.new(150000) { |index| Environment.new }
# 
# (0..500000).each do |i|
#   eval "x#{i} = 'nnn'"
# end
# 
# puts "Execution context: %dM in %d objects" %
#   [`ps -o rss= -p #{Process.pid}`.to_i/1024, ObjectSpace.count_objects[:TOTAL]]
# 
# def do_something_else(&block)
#   block.call
# end
# 
# def func1(&block)
#   do_something_else(&block)
# end
# 
# measure do
#   (0..100).each do
#     func1 do
#       x4 = 'moo'
#       puts "%dM" % (`ps -o rss= -p #{Process.pid}`.to_i/1024)
#     end
#   end
# end
