#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
require 'cell'

class HexCell < Cell
  attr_accessor :northeast, :northwest
  attr_accessor :southeast, :southwest

  def neighbors
    list = []
    list << northwest if northwest
    list << north if north
    list << northeast if northeast
    list << southwest if southwest
    list << south if south
    list << southeast if southeast
    list
  end
end
