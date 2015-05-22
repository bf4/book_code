#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
require 'cell'

class OverCell < Cell
  def initialize(row, column, grid)
    super(row, column)
    @grid = grid
  end

  def neighbors
    list = super 

    list << north.north if can_tunnel_north? 
    list << south.south if can_tunnel_south?
    list << east.east   if can_tunnel_east?
    list << west.west   if can_tunnel_west?

    list
  end

  def can_tunnel_north?
    north && north.north &&
      north.horizontal_passage?
  end

  def can_tunnel_south?
    south && south.south &&
      south.horizontal_passage?
  end

  def can_tunnel_east?
    east && east.east &&
      east.vertical_passage?
  end

  def can_tunnel_west?
    west && west.west &&
      west.vertical_passage?
  end

  def horizontal_passage?
    linked?(east) && linked?(west) &&
      !linked?(north) && !linked?(south)
  end

  def vertical_passage?
    linked?(north) && linked?(south) &&
      !linked?(east) && !linked?(west)
  end

  def link(cell, bidi=true)
    if north && north == cell.south 
      neighbor = north
    elsif south && south == cell.north
      neighbor = south
    elsif east && east == cell.west
      neighbor = east
    elsif west && west == cell.east
      neighbor = west
    end 

    if neighbor 
      @grid.tunnel_under(neighbor) 
    else
      super
    end
  end
end

class UnderCell < Cell
  def initialize(over_cell)
    super(over_cell.row, over_cell.column) 

    if over_cell.horizontal_passage?
      self.north = over_cell.north 
      over_cell.north.south = self
      self.south = over_cell.south
      over_cell.south.north = self 

      link(north)
      link(south)
    else
      self.east = over_cell.east 
      over_cell.east.west = self
      self.west = over_cell.west
      over_cell.west.east = self 

      link(east)
      link(west)
    end
  end

  def horizontal_passage?
    east || west
  end

  def vertical_passage?
    north || south
  end
end
