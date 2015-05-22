#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
class Wilsons

  def self.on(grid)
    unvisited = [] 
    grid.each_cell { |cell| unvisited << cell }

    first = unvisited.sample 
    unvisited.delete(first) 

    while unvisited.any? 
      cell = unvisited.sample 
      path = [cell]

      while unvisited.include?(cell) 
        cell = cell.neighbors.sample 
        position = path.index(cell) 
        if position
          path[(position + 1)..-1] = [] 
        else
          path << cell 
        end
      end 

      (path.length - 1).times do |index| 
        path[index].link(path[index + 1]) 
        unvisited.delete(path[index]) 
      end 
    end

    grid
  end

end
