#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
class Kruskals

  class State
    attr_reader :neighbors

    def initialize(grid) 
      @grid = grid
      @neighbors = [] 
      @set_for_cell = {} 
      @cells_in_set = {} 

      @grid.each_cell do |cell|
        set = @set_for_cell.length 

        @set_for_cell[cell] = set
        @cells_in_set[set] = [ cell ] 

        @neighbors << [cell, cell.south] if cell.south
        @neighbors << [cell, cell.east]  if cell.east
      end
    end

    def can_merge?(left, right)
      @set_for_cell[left] != @set_for_cell[right]
    end

    def merge(left, right)
      left.link(right) 

      winner = @set_for_cell[left]
      loser  = @set_for_cell[right]
      losers = @cells_in_set[loser] || [right]

      losers.each do |cell|
        @cells_in_set[winner] << cell
        @set_for_cell[cell] = winner
      end

      @cells_in_set.delete(loser) 
    end

    def add_crossing(cell)
      return false if cell.links.any? ||     
        !can_merge?(cell.east, cell.west) || 
        !can_merge?(cell.north, cell.south) 

      @neighbors.delete_if { |left,right| left == cell || right == cell } 

      if rand(2) == 0 
        merge(cell.west, cell)
        merge(cell, cell.east)

        @grid.tunnel_under(cell)
        merge(cell.north, cell.north.south)
        merge(cell.south, cell.south.north)
      else
        merge(cell.north, cell)
        merge(cell, cell.south)

        @grid.tunnel_under(cell)
        merge(cell.west, cell.west.east)
        merge(cell.east, cell.east.west)
      end

      true
    end
  end

  def self.on(grid, state=State.new(grid))
    neighbors = state.neighbors.shuffle

    while neighbors.any?
      left, right = neighbors.pop
      state.merge(left, right) if state.can_merge?(left, right)
    end

    grid
  end

end
