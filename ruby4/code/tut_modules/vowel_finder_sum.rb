#---
# Excerpted from "Programming Ruby 1.9 and 2.0",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ruby4 for more book information.
#---
module Summable
  def sum
    inject(:+)
  end
end

class Array
  include Summable
end

class Range
  include Summable
end

require_relative "vowel_finder" #!sh!
class VowelFinder
  include Summable
end

[ 1, 2, 3, 4, 5 ].sum
('a'..'m').sum

vf = VowelFinder.new("the quick brown fox jumped")
vf.sum
