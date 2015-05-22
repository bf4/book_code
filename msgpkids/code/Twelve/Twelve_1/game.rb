#---
# Excerpted from "Learn Game Programming with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msgpkids for more book information.
#---
require_relative 'square'

class Game
  def initialize(window)
    @window = window
    @squares = []
    @color_list = []
    [:red, :green, :blue].each do |color|
      12.times do 
        @color_list.push color
      end
    end
    @color_list.shuffle!
    (0..5).each do |row|
      (0..5).each do |col|
        @squares.push Square.new(@window, col, row, @color_list[row * 6 + col])
      end
    end
  end
  def handle_mouse_down(x,y)
    row = (y.to_i - 20)/100
    col = (x.to_i - 20)/100
    @start_square = get_square(col, row)
  end
  def get_square(col, row)
    if col < 0 or col > 5 or row < 0 or row > 5
      return nil
    else
      return @squares[row * 6 + col]
    end
  end
  def handle_mouse_up(x, y)
    row = (y.to_i - 20)/100
    col = (x.to_i - 20)/100
    @end_square = get_square(col, row)
    if @start_square and @end_square
      move(@start_square, @end_square)
    end
  end
  def move(square1, square2)
    return if square1.number == 0
    if square1.row == square2.row
      squares = squares_between_in_row(square1, square2)
    elsif square1.col == square2.col
      squares = squares_between_in_col(square1, square2)
    else
      return 
    end
    squares.reject!{|square| square.number == 0}
    return if squares.count != 2
    return if squares[0].color != squares[1].color
    #valid move
    color = squares[0].color
    number = squares[0].number + squares[1].number
    squares[0].clear
    squares[1].clear
    square2.set(color, number)
  end
  def squares_between_in_row(square1, square2)
    the_squares = []
    if square1.col < square2.col
      col_start, col_end = square1.col, square2.col
    else
      col_start, col_end = square2.col, square1.col 
    end
    (col_start .. col_end).each do |col|
      the_squares.push get_square(col, square1.row)
    end
    return the_squares
  end

  def squares_between_in_col(square1, square2)
    the_squares = []
    if square1.row < square2.row
      row_start, row_end = square1.row, square2.row
    else 
      row_start, row_end = square2.row, square1.row
    end
    (row_start .. row_end).each do |row|
      the_squares.push get_square(square1.col, row)
    end
    return the_squares
  end
 
 
  def draw
    @squares.each do |square|
      square.draw
    end
  end
end
