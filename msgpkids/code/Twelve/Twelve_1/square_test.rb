#---
# Excerpted from "Learn Game Programming with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msgpkids for more book information.
#---
require 'gosu'
require_relative 'square'

class SquareTest < Gosu::Window

  def initialize
    super 840,640,false
    self.caption = "Testing Squares"
    @square1 = Square.new(self,0,0,:blue)
    @square2 = Square.new(self,1,3,:red)
  end

  def draw
  	@square1.draw
  	@square2.draw
  end
end

window = SquareTest.new
window.show