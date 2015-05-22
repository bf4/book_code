#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
require 'grid'

class CylinderGrid < Grid
  def [](row, column)
    return nil unless row.between?(0, @rows - 1)
    column = column % @grid[row].count
    @grid[row][column]
  end
end
