#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
require 'colored_grid'
require 'binary_tree'

grid = ColoredGrid.new(25, 25)
BinaryTree.on(grid)

start = grid[grid.rows / 2, grid.columns / 2] 

grid.distances = start.distances

filename = "colorized.png"
grid.to_png.save(filename)
puts "saved to #{filename}"
