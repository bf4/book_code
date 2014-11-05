#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# A basic unit test for the Computer class

require_relative 'data_source'
require 'test/unit'

class ComputerTest < Test::Unit::TestCase
  def setup
    @computer = Computer.new(60, DS.new)
  end
  
  def test_returns_a_printable_description
    assert_equal "Mouse: Wireless Touch ($60)", @computer.mouse
  end
  
  def test_marks_expensive_items_with_an_asterisk
    assert_equal "* Cpu: 2.9 Ghz quad-core ($120)", @computer.cpu
  end
end
