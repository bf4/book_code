#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
require 'cylinder_grid'

class MoebiusGrid < CylinderGrid
  def initialize(rows, columns)
    super(rows, columns*2) 
  end

  def to_png(cell_size: 10, inset: 0)
    grid_height = cell_size * rows
    mid_point = columns / 2 

    img_width = cell_size * mid_point 
    img_height = grid_height * 2

    inset = (cell_size * inset).to_i

    background = ChunkyPNG::Color::WHITE
    wall = ChunkyPNG::Color::BLACK

    img = ChunkyPNG::Image.new(img_width + 1, img_height + 1, background)

    [:backgrounds, :walls].each do |mode|
      each_cell do |cell|
        x = (cell.column % mid_point) * cell_size 
        y = cell.row * cell_size

        y += grid_height if cell.column >= mid_point 

        if inset > 0
          to_png_with_inset(img, cell, mode, cell_size, wall, x, y, inset)
        else
          to_png_without_inset(img, cell, mode, cell_size, wall, x, y)
        end
      end
    end

    img
  end
end
