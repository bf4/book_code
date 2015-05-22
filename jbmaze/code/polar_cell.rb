#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
require 'cell'

class PolarCell < Cell
  attr_accessor :cw, :ccw, :inward 
  attr_reader :outward 

  def initialize(row, column)
    super
    @outward = [] 
  end

  def neighbors
    list = []
    list << cw if cw
    list << ccw if ccw
    list << inward if inward
    list += outward
    list
  end
end
