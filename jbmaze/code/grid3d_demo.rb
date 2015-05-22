#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
require 'grid3d'
require 'recursive_backtracker'

grid = Grid3D.new(3, 3, 3)
RecursiveBacktracker.on(grid)

filename = "3d.png"
grid.to_png(cell_size: 20).save(filename)
puts "saved to #{filename}"
