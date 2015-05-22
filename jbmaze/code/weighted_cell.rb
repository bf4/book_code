#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
require 'cell'

class WeightedCell < Cell
  attr_accessor :weight

  def initialize(row, column)
    super(row, column)
    @weight = 1
  end

  def distances
    weights = Distances.new(self)
    pending = [ self ] 

    while pending.any? 
      cell = pending.sort_by { |c| weights[c] }.first 
      pending.delete(cell)

      cell.links.each do |neighbor| 
        total_weight = weights[cell] + neighbor.weight 
        if !weights[neighbor] || total_weight < weights[neighbor] 
          pending << neighbor
          weights[neighbor] = total_weight
        end
      end
    end

    weights
  end
end
