#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
require 'grid'

class Cell3D < Cell
  attr_reader :level
  attr_accessor :up, :down

  def initialize(level, row, column)
    @level = level
    super(row, column)
  end

  def neighbors
    list = super
    list << up if up
    list << down if down
    list
  end
end

class Grid3D < Grid
  attr_reader :levels

  def initialize(levels, rows, columns)
    @levels = levels
    super(rows, columns)
  end

  def prepare_grid
    Array.new(levels) do |level|
      Array.new(rows) do |row|
        Array.new(columns) do |column|
          Cell3D.new(level, row, column)
        end
      end
    end
  end

  def configure_cells
    each_cell do |cell|
      level, row, col = cell.level, cell.row, cell.column

      cell.north = self[level, row - 1, col]
      cell.south = self[level, row + 1, col]
      cell.west  = self[level, row, col - 1]
      cell.east  = self[level, row, col + 1]

      cell.down  = self[level - 1, row, col]
      cell.up    = self[level + 1, row, col]
    end
  end

  def [](level, row, column)
    return nil unless level.between?(0, @levels - 1)
    return nil unless row.between?(0, @grid[level].count - 1)
    return nil unless column.between?(0, @grid[level][row].count - 1)
    @grid[level][row][column]
  end

  def random_cell
    level  = rand(@levels)
    row    = rand(@grid[level].count)
    column = rand(@grid[level][row].count)

    @grid[level][row][column]
  end

  def size
    @levels * @rows * @columns
  end

  def each_level
    @grid.each do |level|
      yield level
    end
  end

  def each_row
    each_level do |rows|
      rows.each do |row|
        yield row
      end
    end
  end

  def to_png(cell_size: 10, inset: 0, margin: cell_size/2)
    inset = (cell_size * inset).to_i

    grid_width = cell_size * columns 
    grid_height = cell_size * rows 

    img_width = grid_width * levels + (levels - 1) * margin 
    img_height = grid_height

    background = ChunkyPNG::Color::WHITE
    wall = ChunkyPNG::Color::BLACK
    arrow = ChunkyPNG::Color.rgb(255, 0, 0) 

    img = ChunkyPNG::Image.new(img_width + 1, img_height + 1, background)

    [:backgrounds, :walls].each do |mode|
      each_cell do |cell|
        x = cell.level * (grid_width + margin) + cell.column * cell_size 
        y = cell.row * cell_size

        if inset > 0
          to_png_with_inset(img, cell, mode, cell_size, wall, x, y, inset)
        else
          to_png_without_inset(img, cell, mode, cell_size, wall, x, y)
        end

        if mode == :walls 
          mid_x = x + cell_size / 2
          mid_y = y + cell_size / 2

          if cell.linked?(cell.down)
            img.line(mid_x-3, mid_y, mid_x-1, mid_y+2, arrow)
            img.line(mid_x-3, mid_y, mid_x-1, mid_y-2, arrow)
          end

          if cell.linked?(cell.up)
            img.line(mid_x+3, mid_y, mid_x+1, mid_y+2, arrow)
            img.line(mid_x+3, mid_y, mid_x+1, mid_y-2, arrow)
          end
        end 
      end
    end

    img
  end

end
