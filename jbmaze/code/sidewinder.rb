#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
class Sidewinder

  def self.on(grid)
    grid.each_row do |row| 
      run = []

      row.each do |cell|
        run << cell

        at_eastern_boundary  = (cell.east == nil) 
        at_northern_boundary = (cell.north == nil) 

        should_close_out = 
          at_eastern_boundary ||
          (!at_northern_boundary && rand(2) == 0) 

        if should_close_out
          member = run.sample
          member.link(member.north) if member.north
          run.clear
        else
          cell.link(cell.east)
        end
      end
    end

    grid
  end

end
