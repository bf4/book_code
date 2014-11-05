#!/usr/local/bin/ruby -w
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---

# chessboard in format {square => neighbors_array}
$board = Hash.new

# finds all the knight jumps from a given square
def neighbors( square )
  # consult cache, if it's available
  return $board[square] unless $board[square].nil?
  
  # otherwise calculate all jumps
  x, y = square[0] - ?a, square[1, 1].to_i - 1
  steps = Array.new
  
  [-1, 1].each do |s_off|
    [-2, 2].each do |l_off|
      [[s_off, l_off], [l_off, s_off]].each do |(x_off, y_off)|
        next_x, next_y = x + x_off, y + y_off
      
        next if next_x < 0 or next_x > 7
        next if next_y < 0 or next_y > 7
      
        steps << "#{(?a + next_x).chr}#{next_y + 1}"
      end
    end
  end
  
  # add this lookup to cache
  $board[square] = steps
end

# find a path using a breadth-first search
def pathfind( from, to, skips )
  paths = [[from]]
  until paths.empty? or paths.first.last == to
    path = paths.shift
    neighbors(path.last).each do |choice|
      next if path.include?(choice) or skips.include?(choice)
      paths.push(path.dup << choice)
    end
  end

  if paths.empty?
    nil
  else
    paths.shift.values_at(1..-1)
  end
end

# parse command-line arguments
if ARGV.size < 2 and ARGV.any? { |square| square !~ /^[a-h][1-8]$/ }
  puts "Usage:  #{File.basename(__FILE__)} START STOP [SKIPS]"
  exit
end
start, stop = ARGV.shift, ARGV.shift
skips       = ARGV

# find path and print results
p pathfind(start, stop, skips)
