#!/usr/bin/env ruby
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---

# Helper class

class Tile
  attr_reader :x, :y
  protected   :x, :y

  def initialize(x, y)
    @x, @y = x, y
  end

  def Tile.named(s)
    Tile.new(s.downcase[0] - ?a, s[1] - ?1)
  end

  def valid?
    (0...8) === @x and (0...8) === @y
  end

  def to_s
    to_str
  end

  def to_str
    %w(a b c d e f g h)[@x] + %w(1 2 3 4 5 6 7 8)[@y] if valid?
  end

  def ==(c)
    @x == c.x and @y == c.y
  end

  def adjacent?(c)
    dx = (@x - c.x).abs
    dy = (@y - c.y).abs
    valid? and c.valid? and (dx == 1 && dy == 2 or dx == 2 && dy == 1)
  end
end



def knights_trip(start, finish, *forbidden)
  # First, build big bucket o' tiles.
  board = (0...64).collect { |n| Tile.new(n % 8, n / 8) }

  # Second, pull out forbidden tiles.
  board.reject! { |t| forbidden.include?(t) }

  # Third, prepare a hash, where layer 0 is just the start.
  # Remove start from the board.
  x = 0
  flood = { x => [start] }
  board.delete(start)

  # Fourth, perform a "flood fill" step, finding all board tiles
  # adjacent to the previous step.
  until flood[x].empty? or flood[x].include?(finish) do
    x += 1
    flood[x] = flood[x-1].inject([]) do |mem, obj|
      mem.concat(board.find_all { |t| t.adjacent?(obj) })
    end

    # Remove those found from the board.
    board.reject! { |t| flood[x].include?(t) }
  end

  # Finally, determine whether we found a way to the finish and, if so,
  # build a path.
  if not flood[x].empty?
    # We found a way. Time to build the path. This is built
    # backwards, so finish goes in first.
    path = [finish]

    # Since we got to finish in X steps, we know there must be
    # at least one adjacent to finish at X-1 steps, and so on.
    until x == 0
      x -= 1

      # Find in flood[x] a tile adjacent to the head of our
      # path. Doesn't matter which one. Make it the new head
      # of our path.
      jumps = flood[x].find_all { |t| t.adjacent?(path.first) }
      path[0,0] = jumps.sort_by { rand }.first
    end

    # Tada!
    path
  end
end



# main
args = ARGV.collect { |arg| Tile.named(arg) }
if args.any? { |c| not c.valid? }
  puts "Invalid argument(s)!"
else
  trip = knights_trip(*args)
  if trip
    puts "Knight's trip: " + trip.join(", ")
  else
    puts "No route available!"
  end
end

