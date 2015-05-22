#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
require 'distances'

class Cell
  attr_reader :row, :column
  attr_accessor :north, :south, :east, :west

  def initialize(row, column)
    @row, @column = row, column
    @links = {}
  end

  def link(cell, bidi=true)
    @links[cell] = true
    cell.link(self, false) if bidi
    self
  end

  def unlink(cell, bidi=true)
    @links.delete(cell)
    cell.unlink(self, false) if bidi
    self
  end

  def links
    @links.keys
  end

  def linked?(cell)
    @links.key?(cell)
  end

  def neighbors
    list = []
    list << north if north
    list << south if south
    list << east  if east
    list << west  if west
    list
  end

  def distances
    distances = Distances.new(self) 
    frontier = [ self ]

    while frontier.any? 
      new_frontier = [] 

      frontier.each do |cell| 
        cell.links.each do |linked| 
          next if distances[linked] 
          distances[linked] = distances[cell] + 1 
          new_frontier << linked 
        end
      end

      frontier = new_frontier 
    end

    distances
  end
end
