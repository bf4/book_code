#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
require 'cell'

class TriangleCell < Cell
  def upright?
    (row + column).even?
  end

  def neighbors
    list = []
    list << west if west
    list << east if east
    list << north if !upright? && north
    list << south if upright? && south
    list
  end
end
