#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
require 'polar_grid'

class HemisphereCell < PolarCell
  attr_reader :hemisphere 

  def initialize(hemisphere, row, column)
    @hemisphere = hemisphere
    super(row, column)
  end
end

class HemisphereGrid < PolarGrid
  attr_reader :id 

  def initialize(id, rows)
    @id = id
    super(rows)
  end

  def size(row) 
    @grid[row].length
  end

  def prepare_grid
    grid = Array.new(@rows)

    angular_height = Math::PI / (2 * @rows) 

    grid[0] = [ HemisphereCell.new(id, 0, 0) ]

    (1...@rows).each do |row|
      theta = (row + 1) * angular_height 
      radius = Math.sin(theta)
      circumference = 2 * Math::PI * radius 

      previous_count = grid[row - 1].length
      estimated_cell_width = circumference / previous_count
      ratio = (estimated_cell_width / angular_height).round

      cells = previous_count * ratio
      grid[row] = Array.new(cells) { |col| HemisphereCell.new(id, row, col) }
    end

    grid
  end
end

class SphereGrid < Grid
  def initialize(rows)
    unless rows.even? 
      raise ArgumentError, "argument must be an even number"
    end

    @equator = rows / 2 
    super(rows, 1)
  end

  def prepare_grid
    Array.new(2) { |id| HemisphereGrid.new(id, @equator) } 
  end

  def configure_cells
    belt = @equator - 1
    size(belt).times do |index| 
      a, b = self[0, belt, index], self[1, belt, index]
      a.outward << b
      b.outward << a
    end 
  end

  def [](hemi, row, column)
    @grid[hemi][row, column]
  end

  def size(row)
    @grid[0].size(row)
  end

  def each_cell
    @grid.each do |hemi|
      hemi.each_cell { |cell| yield cell }
    end
  end

  def random_cell
    @grid.sample.random_cell
  end

  def to_png(ideal_size: 10) 
    img_height = ideal_size * @rows 
    img_width = @grid[0].size(@equator - 1) * ideal_size 

    background = ChunkyPNG::Color::WHITE
    wall = ChunkyPNG::Color::BLACK

    img = ChunkyPNG::Image.new(img_width + 1, img_height + 1, background)

    each_cell do |cell|
      row_size = size(cell.row)
      cell_width = img_width.to_f / row_size 

      x1 = cell.column * cell_width
      x2 = x1 + cell_width

      y1 = cell.row * ideal_size
      y2 = y1 + ideal_size

      if cell.hemisphere > 0 
        y1 = img_height - y1
        y2 = img_height - y2
      end 

      x1 = x1.round; y1 = y1.round
      x2 = x2.round; y2 = y2.round

      if cell.row > 0
        img.line(x2, y1, x2, y2, wall) unless cell.linked?(cell.cw)
        img.line(x1, y1, x2, y1, wall) unless cell.linked?(cell.inward)
      end

      if cell.hemisphere == 0 && cell.row == @equator - 1 
        img.line(x1, y2, x2, y2, wall) unless cell.linked?(cell.outward[0])
      end 
    end

    img
  end
end
