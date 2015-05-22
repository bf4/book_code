#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
class RecursiveBacktracker

  def self.on(grid, start_at: grid.random_cell)
    stack = [] 
    stack.push start_at  

    while stack.any? 
      current = stack.last 
      neighbors = current.neighbors.select { |n| n.links.empty? } 

      if neighbors.empty?
        stack.pop 
      else
        neighbor = neighbors.sample 
        current.link(neighbor) 
        stack.push(neighbor) 
      end
    end

    grid
  end

  def self.recursively_on(grid, start_at: grid.random_cell)
    walk_from(start_at)
    grid
  end

  def self.walk_from(cell) 
    cell.neighbors.shuffle.each do |neighbor| 
      if neighbor.links.empty? 
        cell.link(neighbor) 
        walk_from(neighbor) 
      end
    end
  end

end
