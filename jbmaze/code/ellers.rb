#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
class Ellers

  class RowState
    def initialize(starting_set=0)
      @cells_in_set = {}
      @set_for_cell = []
      @next_set = starting_set
    end

    def record(set, cell)
      @set_for_cell[cell.column] = set

      @cells_in_set[set] = [] if !@cells_in_set[set]
      @cells_in_set[set].push cell
    end

    def set_for(cell)
      if !@set_for_cell[cell.column]
        record(@next_set, cell)
        @next_set += 1
      end

      @set_for_cell[cell.column]
    end

    def merge(winner, loser)
      @cells_in_set[loser].each do |cell|
        @set_for_cell[cell.column] = winner
        @cells_in_set[winner].push cell
      end

      @cells_in_set.delete(loser)
    end

    def next
      RowState.new(@next_set)
    end

    def each_set
      @cells_in_set.each { |set, cells| yield set, cells }
      self
    end
  end

  def self.on(grid)
    row_state = RowState.new

    grid.each_row do |row|
      row.each do |cell| 
        next unless cell.west 

        set = row_state.set_for(cell) 
        prior_set = row_state.set_for(cell.west) 

        should_link = set != prior_set && 
                      (cell.south.nil? || rand(2) == 0) 

        if should_link
          cell.link(cell.west)
          row_state.merge(prior_set, set) 
        end
      end

      if row[0].south 
        next_row = row_state.next 

        row_state.each_set do |set, list| 
          list.shuffle.each_with_index do |cell, index| 
            if index == 0 || rand(3) == 0 
              cell.link(cell.south) 
              next_row.record(row_state.set_for(cell), cell.south) 
            end
          end
        end

        row_state = next_row 
      end
    end
  end

end
