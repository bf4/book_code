#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
require 'grid'

class CubeCell < Cell
  attr_reader :face

  def initialize(face, row, column)
    @face = face
    super(row, column)
  end
end

class CubeGrid < Grid
  alias dim rows

  def initialize(dim)
    super(dim, dim)
  end

  def prepare_grid
    Array.new(6) do |face|
      Array.new(dim) do |row|
        Array.new(dim) do |column|
          CubeCell.new(face, row, column)
        end
      end
    end
  end

  def each_face
    @grid.each do |face|
      yield face
    end
  end

  def each_row
    each_face do |face|
      face.each do |row|
        yield row
      end
    end
  end

  def random_cell
    face   = rand(6)
    row    = rand(dim)
    column = rand(dim)

    @grid[face][row][column]
  end

  def size
    6 * dim * dim
  end

  def configure_cells
    each_cell do |cell|
      face, row, column = cell.face, cell.row, cell.column

      cell.west  = self[face, row, column-1]
      cell.east  = self[face, row, column+1]
      cell.north = self[face, row-1, column]
      cell.south = self[face, row+1, column]
    end
  end

  def [](face, row, column)
    return nil if face < 0 || face >= 6
    face, row, column = wrap(face, row, column)
    @grid[face][row][column]
  end

  def wrap(face, row, column)
    n = dim-1

    if row < 0
      return [4, column, 0]   if face == 0
      return [4, n, column]   if face == 1
      return [4, n-column, n] if face == 2
      return [4, 0, n-column] if face == 3
      return [3, 0, n-column] if face == 4
      return [1, n, column]   if face == 5
    elsif row >= dim
      return [5, n-column, 0] if face == 0
      return [5, 0, column]   if face == 1
      return [5, column, n]   if face == 2
      return [5, n, n-column] if face == 3
      return [1, 0, column]   if face == 4
      return [3, n, n-column] if face == 5
    elsif column < 0
      return [3, row, n]      if face == 0
      return [0, row, n]      if face == 1
      return [1, row, n]      if face == 2
      return [2, row, n]      if face == 3
      return [0, 0, row]      if face == 4
      return [0, n, n-row]    if face == 5
    elsif column >= dim 
      return [1, row, 0]      if face == 0
      return [2, row, 0]      if face == 1 
      return [3, row, 0]      if face == 2
      return [0, row, 0]      if face == 3
      return [2, 0, n-row]    if face == 4
      return [2, n, row]      if face == 5
    end

    [face, row, column] 
  end

  def to_png(cell_size: 10, inset: 0)
    inset = (cell_size * inset).to_i

    face_width = cell_size * dim 
    face_height = cell_size * dim 

    img_width = 4 * face_width 
    img_height = 3 * face_height 

    offsets = [[0, 1], [1, 1], [2, 1], [3, 1], [1, 0], [1, 2]] 

    background = ChunkyPNG::Color::WHITE
    wall = ChunkyPNG::Color::BLACK
    outline = ChunkyPNG::Color.rgb(0xd0, 0xd0, 0xd0)

    img = ChunkyPNG::Image.new(img_width + 1, img_height + 1, background)
    
    draw_outlines(img, face_width, face_height, outline) 

    [:backgrounds, :walls].each do |mode|
      each_cell do |cell|
        x = offsets[cell.face][0] * face_width + cell.column * cell_size 
        y = offsets[cell.face][1] * face_height + cell.row * cell_size 

        if inset > 0
          to_png_with_inset(img, cell, mode, cell_size, wall, x, y, inset)
        else
          to_png_without_inset(img, cell, mode, cell_size, wall, x, y)
        end
      end
    end

    img
  end

  def draw_outlines(img, height, width, outline)
    # face #0
    img.rect(0, height, width, height*2, outline)
    
    # faces #2 & #3
    img.rect(width*2, height, width*4, height*2, outline)
    # line between faces #2 & #3
    img.line(width*3, height, width*3, height*2, outline)

    # face #4
    img.rect(width, 0, width*2, height, outline)

    # face #5
    img.rect(width, height*2, width*2, height*3, outline)
  end

  def to_png_without_inset(img, cell, mode, cell_size, wall, x, y)
    x1, y1 = x, y
    x2 = x1 + cell_size
    y2 = y1 + cell_size

    if mode == :backgrounds
      color = background_color_for(cell)
      img.rect(x, y, x2, y2, color, color) if color
    else
      if cell.north.face != cell.face && !cell.linked?(cell.north)
        img.line(x1, y1, x2, y1, wall)
      end

      if cell.west.face != cell.face && !cell.linked?(cell.west)
        img.line(x1, y1, x1, y2, wall)
      end

      img.line(x2, y1, x2, y2, wall) unless cell.linked?(cell.east)
      img.line(x1, y2, x2, y2, wall) unless cell.linked?(cell.south)
    end
  end
end
