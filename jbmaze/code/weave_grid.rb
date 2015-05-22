#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
require 'grid'
require 'weave_cells'

class WeaveGrid < Grid
  def initialize(rows, columns)
    @under_cells = [] 
    super
  end

  def prepare_grid
    Array.new(rows) do |row|
      Array.new(columns) do |column|
        OverCell.new(row, column, self) 
      end
    end
  end

  def tunnel_under(over_cell) 
    under_cell = UnderCell.new(over_cell)
    @under_cells.push under_cell
  end

  def each_cell
    super

    @under_cells.each do |cell| 
      yield cell
    end
  end

  def to_png(cell_size: 10, inset: nil)
    super cell_size: cell_size, inset: (inset || 0.1) 
  end

  def to_png_with_inset(img, cell, mode, cell_size, wall, x, y, inset)
    if cell.is_a?(OverCell) 
      super
    else
      x1, x2, x3, x4, y1, y2, y3, y4 =
        cell_coordinates_with_inset(x, y, cell_size, inset)

      if cell.vertical_passage?
        img.line(x2, y1, x2, y2, wall)
        img.line(x3, y1, x3, y2, wall)
        img.line(x2, y3, x2, y4, wall)
        img.line(x3, y3, x3, y4, wall)
      else
        img.line(x1, y2, x2, y2, wall)
        img.line(x1, y3, x2, y3, wall)
        img.line(x3, y2, x4, y2, wall)
        img.line(x3, y3, x4, y3, wall)
      end
    end
  end
end
