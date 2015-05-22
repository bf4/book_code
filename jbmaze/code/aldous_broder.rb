#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
class AldousBroder

  def self.on(grid)
    cell = grid.random_cell 
    unvisited = grid.size - 1 

    while unvisited > 0 
      neighbor = cell.neighbors.sample 

      if neighbor.links.empty?
        cell.link(neighbor) 
        unvisited -= 1 
      end

      cell = neighbor 
    end

    grid
  end

end
