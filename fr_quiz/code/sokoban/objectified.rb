#!/usr/bin/ruby
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---

# Dave's Cheap Ruby Sokoban
#######========--------   --- -   -
# A response to Ruby Quiz of the Week #5 [ruby-talk:118250]
#
# Author: Dave Burt <dave at burt.id.au>
# Created: 1 Nov 2004
# Last modified: 1 Nov 2004
#
# Fine print: Provided as is. Use at your own risk. Unauthorized copying is
#             not disallowed. Credit's appreciated if you use my code. I'd
#             appreciate seeing any modifications you make to it.


module Sokoban

  NORTH = [-1,0]
  SOUTH = [1,0]
  EAST  = [0,1]
  WEST  = [0,-1]

  class SokobanError < StandardError
  end
end



module Sokoban
  class Tile
    def self.create(chr = nil)
      case chr
      when '#' : Wall.new
      when ' ' : Floor.new
      when '@' : Floor.new(Person.new)
      when 'o' : Floor.new(Crate.new)
      when '.' : Storage.new
      when '+' : Storage.new(Person.new)
      when '*' : Storage.new(Crate.new)
      else      CharTile.new(chr)
      end
    end
    def to_s
      '~'
    end
  end
  
  class CharTile < Tile
    attr_reader :chr
    def initialize(chr)
      @chr = chr
    end
    def to_s
      chr
    end
  end
  
  class Wall < Tile
    def to_s
      '#'
    end
  end
  
  class Floor < Tile
    attr_accessor :resident
    def initialize(resident = nil)
      @resident = resident
    end
    def to_s
      return resident.to_s if resident
      ' '
    end
    def clear
      r = @resident
      @resident = nil
      r
    end

    def add(resident)
      throw SokobanError.new("Can't go there - this tile is full") if @resident
      @resident = resident
    end
    alias :<< :add
  end
  
  class Storage < Floor
    def has_crate?
      Crate === resident
    end
    def to_s
      case resident
      when Crate
        '*'
      when Person
        '+'
      else
        '.'
      end
    end
  end
end

  

module Sokoban
  class Crate
    def to_s
      'o'
    end
  end
  
  class Person
    def to_s
      '@'
    end
  end
end



module Sokoban
  class Level
    attr_reader :moves
    def initialize(str)
      @grid = str.split("\n").map{|ln| ln.split(//).map{|c| Tile.create(c) } }
      throw SokobanError.new('No player found on level') if !player_index
      throw SokobanError.new('No challenge!') if solved?
      @moves = 0
    end
    def [](r, c)
      @grid[r][c]
    end
    def to_s
      @grid.map{|row| row.join }.join("\n")
    end
    # returns a 2-element array with the row and column of the
    # player's position, respectively
    def player_index
      @grid.each_index do |row|
        @grid[row].each_index do |col|
          if @grid[row][col].respond_to?(:resident) &&
                             Person === @grid[row][col].resident
            return [row, col]
          end
        end
      end
      nil
    end
    def solved?
      # a level is solved when every Storage tile has a Crate
      @grid.flatten.all? {|tile| !(Storage === tile) || tile.has_crate? }
    end
    def move(dir)
      if [NORTH,SOUTH,EAST,WEST].include?(dir)
        pos = player_index
        target = @grid[pos[0] + dir[0]][pos[1] + dir[1]]
        if Floor === target
          if Crate === target.resident
            indirect_target = @grid[pos[0] + 2*dir[0]][pos[1] + 2*dir[1]]
            if Floor === indirect_target && !indirect_target.resident
              @grid[pos[0] + 2*dir[0]][pos[1] + 2*dir[1]] <<
                    @grid[pos[0] + dir[0]][pos[1] + dir[1]].clear
              @grid[pos[0] + dir[0]][pos[1] + dir[1]] <<
                    @grid[pos[0]][pos[1]].clear
              return @moves += 1
            end
          else
            @grid[pos[0] + dir[0]][pos[1] + dir[1]] <<
                 @grid[pos[0]][pos[1]].clear
            return @moves += 1
          end
        end
      end
      nil
    end
  end
end

  

module Sokoban
  # command-line interface
  def self.cli(levels_file = 'sokoban_levels.txt')
    cli_help = <<-end

        Dave's Cheap Ruby Sokoban  (c) Dave Burt 2004

        @ is you
        + is you standing on storage
        # is a wall
        . is empty storage
        o is a crate
        * is a crate on storage

        Move all the crates onto storage.

        to move:     n/k
                      |
                 w/h -+- e/l
                      |
                     s/j
        to restart the level: r
        to quit: x or q or !
        to show this message: ?

        You can queue commands like this: nwwwnnnwnwwsw...

    end

    cli_help.gsub!(/\t+/,'  :  ')
    puts cli_help

    File.read(levels_file).split("\n\n").
                           each_with_index do |level_string, level_index|
      level = Level.new(level_string)
      while !level.solved? do
        puts level
        print 'L:' + (level_index+1).to_s + ' M:' + level.moves.to_s + ' > '
        gets.split(//).each do |c|
          case c
          when 'w', 'h'
            level.move(WEST)
          when 's', 'j'
            level.move(SOUTH)
          when 'n', 'k'
            level.move(NORTH)
          when 'e', 'l'
            level.move(EAST)
          when 'r'
            level = Level.new(level_string)
          when 'q', 'x', '!'
            puts 'Bye!'
            exit
          when 'd' # debug - ruby prompt
            print 'ruby> '
            begin
              puts eval(gets)
            rescue
              puts $!
            end
          when '?'
            puts cli_help
          when "\n", "\r", "\t", " "
            # ignore whitespace
          else
            puts "Invalid command: '#{c}'"
            puts cli_help
          end
        end
      end
      puts "\nCongratulations - you beat level #{level_index + 1}!\n\n"
    end
  end
end

if $0 == __FILE__
  Sokoban::cli
end

