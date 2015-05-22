#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
ROOMS = false

class RecursiveDivision

  def self.on(grid)
    @grid = grid

    @grid.each_cell do |cell| 
      cell.neighbors.each { |n| cell.link(n, false) }
    end 

    divide(0, 0, @grid.rows, grid.columns) 
  end

  def self.divide(row, column, height, width)
if ROOMS
    return if height <= 1 || width <= 1 ||
      height < 5 && width < 5 && rand(4) == 0
else
    return if height <= 1 || width <= 1 
end

    if height > width
      divide_horizontally(row, column, height, width)
    else
      divide_vertically(row, column, height, width)
    end
  end

  def self.divide_horizontally(row, column, height, width)
    divide_south_of = rand(height-1) 
    passage_at = rand(width) 

    width.times do |x|
      next if passage_at == x

      cell = @grid[row+divide_south_of, column+x] 
      cell.unlink(cell.south) 
    end

    divide(row, column, divide_south_of+1, width) 
    divide(row+divide_south_of+1, column, height-divide_south_of-1, width) 
  end

  def self.divide_vertically(row, column, height, width)
    divide_east_of = rand(width-1)
    passage_at = rand(height)

    height.times do |y|
      next if passage_at == y

      cell = @grid[row+y, column+divide_east_of]
      cell.unlink(cell.east)
    end

    divide(row, column, height, divide_east_of+1)
    divide(row, column+divide_east_of+1, height, width-divide_east_of-1)
  end

end
