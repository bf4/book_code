#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
require 'mask'
require 'masked_grid'
require 'recursive_backtracker'

mask = Mask.new(5, 5) 

mask[0, 0] = false 
mask[2, 2] = false
mask[4, 4] = false 

grid = MaskedGrid.new(mask) 
RecursiveBacktracker.on(grid)

puts grid
