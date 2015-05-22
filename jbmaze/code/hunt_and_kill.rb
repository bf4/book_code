#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
class HuntAndKill

  def self.on(grid)
    current = grid.random_cell 

    while current 
      unvisited_neighbors = current.neighbors.select { |n| n.links.empty? } 

      if unvisited_neighbors.any? 
        neighbor = unvisited_neighbors.sample 
        current.link(neighbor) 
        current = neighbor 
      else 
        current = nil 

        grid.each_cell do |cell| 
          visited_neighbors = cell.neighbors.select { |n| n.links.any? }
          if cell.links.empty? && visited_neighbors.any? 
            current = cell 

            neighbor = visited_neighbors.sample 
            current.link(neighbor) 

            break 
          end
        end 
      end
    end

    grid
  end

end
