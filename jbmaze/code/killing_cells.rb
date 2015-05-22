#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
require 'grid'
require 'recursive_backtracker'

grid = Grid.new(5, 5)

# orphan the cell in the northwest corner...
grid[0, 0].east.west = nil 
grid[0, 0].south.north = nil 

# ...and the one in the southeast corner
grid[4, 4].west.east = nil 
grid[4, 4].north.south = nil 

RecursiveBacktracker.on(grid, start_at: grid[1,1])

puts grid
