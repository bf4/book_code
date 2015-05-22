#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
class GrowingTree

  def self.on(grid, start_at: grid.random_cell)
    active = []
    active.push(start_at)

    while active.any?
      cell = yield active
      available_neighbors = cell.neighbors.select { |n| n.links.empty? }

      if available_neighbors.any?
        neighbor = available_neighbors.sample
        cell.link(neighbor)
        active.push(neighbor)
      else
        active.delete(cell)
      end
    end

    grid
  end

end
