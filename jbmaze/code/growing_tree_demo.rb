#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
require 'growing_tree'
require 'grid'

def save(grid, filename)
  grid.to_png.save(filename)
  puts "saved to #{filename}"
end

grid = Grid.new(20, 20)
GrowingTree.on(grid) { |list| list.sample }
save(grid, "growing-tree-random.png")

grid = Grid.new(20, 20)
GrowingTree.on(grid) { |list| list.last }
save(grid, "growing-tree-last.png")

grid = Grid.new(20, 20)
GrowingTree.on(grid) { |list| (rand(2) == 0) ? list.last : list.sample }
save(grid, "growing-tree-mix.png")
