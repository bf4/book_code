#!/usr/bin/env ruby
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---


class CrossWordPuzzle
  CELL_WIDTH  = 6
  CELL_HEIGHT = 4

  attr_accessor :cell_width, :cell_height

  def initialize(file)
    @file        = file
    @cell_width  = CELL_WIDTH
    @cell_height = CELL_HEIGHT
    build_puzzle
  end

private
  def build_puzzle
    parse_grid_file
    drop_outer_filled_boxes
    create_numbered_grid
  end
end


class CrossWordPuzzle

  private


  def parse_grid_file
    @grid = File.read(@file).split(/\n/)
    @grid.collect! { |line| line.split }
    @grid_width  = @grid.first.size
    @grid_height = @grid.size
  end

end

class CrossWordPuzzle

  private


  def drop_outer_filled_boxes
    loop {
      changed  = _drop_outer_filled_boxes(@grid)
      changed += _drop_outer_filled_boxes(t = @grid.transpose)
      @grid = t.transpose
      break if 0 == changed
    }
  end

  def _drop_outer_filled_boxes(ary)
    changed = 0
    ary.collect! { |row|
      r = row.join
      changed += 1 unless r.gsub!(/^X|X$/, ' ').nil?
      changed += 1 unless r.gsub!(/X | X/, '  ').nil?
      r.split(//)
    }
    changed
  end

end

class CrossWordPuzzle

  private


  def create_numbered_grid
    mark_boxes(@grid)
    mark_boxes(t = @grid.transpose)
    @grid = t.transpose
    count = '0'
    @numbered_grid = []
    @grid.each_with_index { |row, i|
      r = []
      row.each_with_index { |col, j|
        r << case col
             when /#/ then count.succ!.dup
             else col
             end
      }
      @numbered_grid << r
    }
  end

  # place '#' in boxes to be numbered
  def mark_boxes(grid)
    grid.collect! { |row|
      r = row.join
      r.gsub!(/([X ])([\#_]{2,})/) { "#{$1}##{$2[1..-1]}" }
      r.gsub!(/^([\#_]{2,})/) { |m| m[0]=?#; m }
      r.split(//)
    }
  end

end

class CrossWordPuzzle

  private


  def cell(data)
    c = []
    case data
    when 'X'
      @cell_height.times { c << ['#'] * @cell_width }
    when ' '
      @cell_height.times { c << [' '] * @cell_width }
    when /\d/
      tb = ['#'] * @cell_width
      n  = sprintf("#%-#{@cell_width-2}s#", data).split(//)
      m  = sprintf("#%-#{@cell_width-2}s#", ' ').split(//)
      c << tb << n 
      (@cell_height-3).times { c << m }
      c << tb
    when '_'
      tb = ['#'] * @cell_width
      m  = ['#'] + [' ']*(@cell_width-2) + ['#']
      c << tb 
      (@cell_height-2).times { c << m }
      c << tb
    end
    c
  end

  def overlay(sub, mstr, x, y)
    sub.each_with_index { |row, i|
      row.each_with_index { |data, j|
        mstr[y+i][x+j] = data unless '#' == mstr[y+i][x+j]
      }
    }
  end

  def to_s
    puzzle_width  = (@cell_width-1)  * @grid_width  + 1
    puzzle_height = (@cell_height-1) * @grid_height + 1

    s = Array.new(puzzle_height) { Array.new(puzzle_width) << [] }

    @numbered_grid.each_with_index { |row, i|
      row.each_with_index { |data, j|
         overlay(cell(data), s, j*(@cell_width-1), i*(@cell_height-1))
      }
    }
    s.collect! { |row| row.join }.join("\n")
  end


  public :to_s

end  # class CrossWordPuzzle



cwp = CrossWordPuzzle.new(ARGV.shift)
puts cwp.to_s

