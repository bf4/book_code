#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
require 'grid'
require 'binary_tree'
require 'sidewinder'
require 'aldous_broder'
require 'wilsons'
require 'hunt_and_kill'

algorithms = [BinaryTree, Sidewinder, AldousBroder, Wilsons, HuntAndKill] 

tries = 100 
size = 20 

averages = {}
algorithms.each do |algorithm|
  puts "running #{algorithm}..."

  deadend_counts = []
  tries.times do
    grid = Grid.new(size, size) 
    algorithm.on(grid) 
    deadend_counts << grid.deadends.count 
  end

  total_deadends = deadend_counts.inject(0) { |s,a| s + a } 
  averages[algorithm] = total_deadends / deadend_counts.length 
end

total_cells = size * size
puts
puts "Average dead-ends per #{size}x#{size} maze (#{total_cells} cells):"
puts

sorted_algorithms = algorithms.sort_by { |algorithm| -averages[algorithm] }

sorted_algorithms.each do |algorithm|
  percentage = averages[algorithm] * 100.0 / (size * size)
  puts "%14s : %3d/%d (%d%%)" %
    [algorithm, averages[algorithm], total_cells, percentage]
end
