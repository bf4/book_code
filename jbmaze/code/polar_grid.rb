#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
require 'grid'
require 'polar_cell'

class PolarGrid < Grid
  def initialize(rows)
    super(rows, 1)
  end

  def prepare_grid
    rows = Array.new(@rows) 

    row_height = 1.0 / @rows 
    rows[0] = [ PolarCell.new(0, 0) ] 

    (1...@rows).each do |row|
      radius = row.to_f / @rows 
      circumference = 2 * Math::PI * radius 

      previous_count = rows[row - 1].length
      estimated_cell_width = circumference / previous_count 
      ratio = (estimated_cell_width / row_height).round 

      cells = previous_count * ratio 
      rows[row] = Array.new(cells) { |col| PolarCell.new(row, col) } 
    end

    rows
  end

  def configure_cells
    each_cell do |cell|
      row, col = cell.row, cell.column

      if row > 0 
        cell.cw  = self[row, col + 1] 
        cell.ccw = self[row, col - 1] 

        ratio = @grid[row].length / @grid[row - 1].length 
        parent = @grid[row - 1][col / ratio] 
        parent.outward << cell 
        cell.inward = parent 
      end
    end
  end

  def [](row, column)
    return nil unless row.between?(0, @rows - 1)
    @grid[row][column % @grid[row].count]
  end

  def random_cell
    row = rand(@rows)
    col = rand(@grid[row].length)
    @grid[row][col]
  end

  def to_png(cell_size: 10)
    to_png_v2(cell_size: cell_size)
  end

  def to_png_v1(cell_size: 10)
    img_size = 2 * @rows * cell_size 

    background = ChunkyPNG::Color::WHITE
    wall = ChunkyPNG::Color::BLACK

    img = ChunkyPNG::Image.new(img_size + 1, img_size + 1, background)
    center = img_size / 2 

    each_cell do |cell|
      theta        = 2 * Math::PI / @grid[cell.row].length 
      inner_radius = cell.row * cell_size
      outer_radius = (cell.row + 1) * cell_size
      theta_ccw    = cell.column * theta
      theta_cw     = (cell.column + 1) * theta 

      ax = center + (inner_radius * Math.cos(theta_ccw)).to_i 
      ay = center + (inner_radius * Math.sin(theta_ccw)).to_i
      bx = center + (outer_radius * Math.cos(theta_ccw)).to_i
      by = center + (outer_radius * Math.sin(theta_ccw)).to_i
      cx = center + (inner_radius * Math.cos(theta_cw)).to_i
      cy = center + (inner_radius * Math.sin(theta_cw)).to_i
      dx = center + (outer_radius * Math.cos(theta_cw)).to_i
      dy = center + (outer_radius * Math.sin(theta_cw)).to_i 

      img.line(ax, ay, cx, cy, wall) unless cell.linked?(cell.north) 
      img.line(cx, cy, dx, dy, wall) unless cell.linked?(cell.east) 
    end

    img.circle(center, center, @rows * cell_size, wall) 
    img
  end

  def to_png_v2(cell_size: 10)
    img_size = 2 * @rows * cell_size

    background = ChunkyPNG::Color::WHITE
    wall = ChunkyPNG::Color::BLACK

    img = ChunkyPNG::Image.new(img_size + 1, img_size + 1, background)
    center = img_size / 2

    each_cell do |cell|
      next if cell.row == 0

      # ...


      theta        = 2 * Math::PI / @grid[cell.row].length
      inner_radius = cell.row * cell_size
      outer_radius = (cell.row + 1) * cell_size
      theta_ccw    = cell.column * theta
      theta_cw     = (cell.column + 1) * theta

      ax = center + (inner_radius * Math.cos(theta_ccw)).to_i
      ay = center + (inner_radius * Math.sin(theta_ccw)).to_i
      bx = center + (outer_radius * Math.cos(theta_ccw)).to_i
      by = center + (outer_radius * Math.sin(theta_ccw)).to_i
      cx = center + (inner_radius * Math.cos(theta_cw)).to_i
      cy = center + (inner_radius * Math.sin(theta_cw)).to_i
      dx = center + (outer_radius * Math.cos(theta_cw)).to_i
      dy = center + (outer_radius * Math.sin(theta_cw)).to_i

      img.line(ax, ay, cx, cy, wall) unless cell.linked?(cell.inward)
      img.line(cx, cy, dx, dy, wall) unless cell.linked?(cell.cw)
    end

    img.circle(center, center, @rows * cell_size, wall)
    img
  end
end
