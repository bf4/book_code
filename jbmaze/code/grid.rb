#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
require 'chunky_png'
require 'cell'

class Grid
  attr_reader :rows, :columns

  def initialize(rows, columns)
    @rows = rows
    @columns = columns

    @grid = prepare_grid
    configure_cells
  end

  def prepare_grid
    Array.new(rows) do |row|
      Array.new(columns) do |column|
        Cell.new(row, column)
      end
    end
  end

  def configure_cells
    each_cell do |cell|
      row, col = cell.row, cell.column

      cell.north = self[row - 1, col]
      cell.south = self[row + 1, col]
      cell.west  = self[row, col - 1]
      cell.east  = self[row, col + 1]
    end
  end

  def [](row, column)
    return nil unless row.between?(0, @rows - 1)
    return nil unless column.between?(0, @grid[row].count - 1)
    @grid[row][column]
  end

  def random_cell
    row = rand(@rows)
    column = rand(@grid[row].count)

    self[row, column]
  end

  def size
    @rows * @columns
  end

  def each_row
    @grid.each do |row|
      yield row
    end
  end

  def each_cell
    each_row do |row|
      row.each do |cell|
        yield cell if cell
      end
    end
  end

  # By default, we'll simply display a cell as a blank space. We'll use this
  # to add other ways of displaying cells.
  def contents_of(cell)
    " "
  end
#
  def background_color_for(cell)
    nil
  end

  def to_s
    to_s_v2
  end

  # Version #1 of our #to_s implementation
  def to_s_v1
    output = "+" + "---+" * columns + "\n" 

    each_row do |row| 
      top = "|" 
      bottom = "+" 

      row.each do |cell| 
        cell = Cell.new(-1, -1) unless cell 

        body = "   " # <-- that's THREE (3) spaces!
        east_boundary = (cell.linked?(cell.east) ? " " : "|")
        top << body << east_boundary

        # three spaces below, too >>-------------->> >...<
        south_boundary = (cell.linked?(cell.south) ? "   " : "---") 
        corner = "+"
        bottom << south_boundary << corner
      end

      output << top << "\n"
      output << bottom << "\n"
    end

    output 
  end

  # Version #2 of our #to_s implementation (adds the #contents_of
  # method we can override)
  def to_s_v2
    output = "+" + "---+" * columns + "\n"

    each_row do |row|
      top = "|"
      bottom = "+"

      row.each do |cell|
        cell = Cell.new(-1, -1) unless cell

        body = " #{contents_of(cell)} "
        east_boundary = (cell.linked?(cell.east) ? " " : "|")
        top << body << east_boundary

        south_boundary = (cell.linked?(cell.south) ? "   " : "---") 
        corner = "+"
        bottom << south_boundary << corner
      end

      output << top << "\n"
      output << bottom << "\n"
    end

    output
  end

  def to_png(cell_size: 10)
    to_png_v1(cell_size: cell_size)
  end

  def to_png_v1(cell_size: 10)
    img_width = cell_size * columns 
    img_height = cell_size * rows

    background = ChunkyPNG::Color::WHITE
    wall = ChunkyPNG::Color::BLACK

    img = ChunkyPNG::Image.new(img_width + 1, img_height + 1, background) 

    each_cell do |cell|
      x1 = cell.column * cell_size 
      y1 = cell.row * cell_size
      x2 = (cell.column + 1) * cell_size
      y2 = (cell.row + 1) * cell_size 

      img.line(x1, y1, x2, y1, wall) unless cell.north 
      img.line(x1, y1, x1, y2, wall) unless cell.west 

      img.line(x2, y1, x2, y2, wall) unless cell.linked?(cell.east) 
      img.line(x1, y2, x2, y2, wall) unless cell.linked?(cell.south) 
    end

    img
  end

  def to_png_v2(cell_size: 10)
    img_width = cell_size * columns
    img_height = cell_size * rows

    background = ChunkyPNG::Color::WHITE
    wall = ChunkyPNG::Color::BLACK

    img = ChunkyPNG::Image.new(img_width + 1, img_height + 1, background)

    [:backgrounds, :walls].each do |mode| 
      each_cell do |cell|
        x1 = cell.column * cell_size
        y1 = cell.row * cell_size
        x2 = (cell.column + 1) * cell_size
        y2 = (cell.row + 1) * cell_size

        if mode == :backgrounds 
          color = background_color_for(cell)
          img.rect(x1, y1, x2, y2, color, color) if color
        else
          img.line(x1, y1, x2, y1, wall) unless cell.north 
          img.line(x1, y1, x1, y2, wall) unless cell.west
          img.line(x2, y1, x2, y2, wall) unless cell.linked?(cell.east)
          img.line(x1, y2, x2, y2, wall) unless cell.linked?(cell.south) 
        end
      end
    end

    img
  end

  def to_png(cell_size: 10, inset: 0)
    to_png_v3(cell_size: cell_size, inset: inset)
  end

  def to_png_v3(cell_size: 10, inset: 0)
    img_width = cell_size * columns
    img_height = cell_size * rows
    inset = (cell_size * inset).to_i

    background = ChunkyPNG::Color::WHITE
    wall = ChunkyPNG::Color::BLACK

    img = ChunkyPNG::Image.new(img_width + 1, img_height + 1, background)

    [:backgrounds, :walls].each do |mode|
      each_cell do |cell|
        x = cell.column * cell_size
        y = cell.row * cell_size

        if inset > 0
          to_png_with_inset(img, cell, mode, cell_size, wall, x, y, inset)
        else
          to_png_without_inset(img, cell, mode, cell_size, wall, x, y)
        end
      end
    end

    img
  end

  def to_png_without_inset(img, cell, mode, cell_size, wall, x, y)
    x1, y1 = x, y
    x2 = x1 + cell_size
    y2 = y1 + cell_size

    if mode == :backgrounds
      color = background_color_for(cell)
      img.rect(x, y, x2, y2, color, color) if color
    else
      img.line(x1, y1, x2, y1, wall) unless cell.north
      img.line(x1, y1, x1, y2, wall) unless cell.west
      img.line(x2, y1, x2, y2, wall) unless cell.linked?(cell.east)
      img.line(x1, y2, x2, y2, wall) unless cell.linked?(cell.south)
    end
  end

  def cell_coordinates_with_inset(x, y, cell_size, inset)
    x1, x4 = x, x + cell_size
    x2 = x1 + inset
    x3 = x4 - inset

    y1, y4 = y, y + cell_size
    y2 = y1 + inset
    y3 = y4 - inset

    [x1, x2, x3, x4,
      y1, y2, y3, y4] 
  end

  def to_png_with_inset(img, cell, mode, cell_size, wall, x, y, inset)
    x1, x2, x3, x4, y1, y2, y3, y4 =
      cell_coordinates_with_inset(x, y, cell_size, inset) 

    if mode == :backgrounds
      # ...
    else
      if cell.linked?(cell.north) 
        img.line(x2, y1, x2, y2, wall)
        img.line(x3, y1, x3, y2, wall)
      else
        img.line(x2, y2, x3, y2, wall)
      end

      if cell.linked?(cell.south)
        img.line(x2, y3, x2, y4, wall)
        img.line(x3, y3, x3, y4, wall)
      else
        img.line(x2, y3, x3, y3, wall)
      end

      if cell.linked?(cell.west)
        img.line(x1, y2, x2, y2, wall)
        img.line(x1, y3, x2, y3, wall)
      else
        img.line(x2, y2, x2, y3, wall)
      end

      if cell.linked?(cell.east)
        img.line(x3, y2, x4, y2, wall)
        img.line(x3, y3, x4, y3, wall)
      else
        img.line(x3, y2, x3, y3, wall)
      end 
    end
  end

  def deadends
    list = []

    each_cell do |cell|
      list << cell if cell.links.count == 1
    end

    list
  end

  def braid(p=1.0)
    deadends.shuffle.each do |cell| 
      next if cell.links.count != 1 || rand > p 

      neighbors = cell.neighbors.reject { |n| cell.linked?(n) } 
      best = neighbors.select { |n| n.links.count == 1 } 
      best = neighbors if best.empty? 

      neighbor = best.sample 
      cell.link(neighbor)
    end
  end
end
