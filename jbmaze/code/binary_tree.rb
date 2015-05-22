#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
class BinaryTree

  def self.on(grid)
    grid.each_cell do |cell|
      neighbors = []
      neighbors << cell.north if cell.north
      neighbors << cell.east if cell.east

      index = rand(neighbors.length) 
      neighbor = neighbors[index] 

      cell.link(neighbor) if neighbor
    end

    grid
  end

end
