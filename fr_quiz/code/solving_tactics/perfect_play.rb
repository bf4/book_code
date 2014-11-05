#!/usr/local/bin/ruby -w
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---


class TacticsPosition
  MOVES = [ ]
  # a quick hack to load all possible moves (idea from Bob Sidebotham)
  (0..3).each do |row|
    # take all the moves available in one row...
    [ 0b1000, 0b0100, 0b0010, 0b0001, 0b1100,
      0b0110, 0b0011, 0b1110, 0b0111, 0b1111 ].each do |move|
      # spread it to each row of the board...
      move = move << 4 * row
      MOVES << move
      # and transpose it to the columns too
      MOVES << (0..15).inject(0) do |trans, i|
        q, r = i.divmod(4);
        trans |= move[i] << q + r * 4
      end
    end
  end
  MOVES.uniq!
end



class TacticsPosition
  def initialize( position = 0b0000_0000_0000_0000, player = :first )
    @position = position
    @player   = player
  end
  
  include Enumerable
  
  # passes the new position after each available move to the block
  def each( &block )
    moves.map do |m|
      TacticsPosition.new(@position | m, next_player)
    end.each(&block)
  end
  
  def moves
    MOVES.reject { |m| @position & m != 0 }
  end
  
  def next_player
    if @player == :first then :second else :first end
  end
end



class TacticsPosition
  # the minimum number of plays left from this position
  def minimum_moves_left
    minimum = 0
    game = self
    until game.over?
      game = game.min { |a, b| a.moves.size <=> b.moves.size }
      minimum += 1
    end
    return minimum
  end

  # select a perfect move from this position, returning the resulting position
  def perfect_play
    win = find { |m| m.moves.size == 1 }
    if win    # if we can force a win, do so...
      win
    else      # otherwise, try to ensure at least two more moves
      choices = to_a.sort_by { |m| m.minimum_moves_left }
      best = choices.find { |m| m.moves.size % 2 == 0 }
      best or choices.first
    end
  end
  
  def over?
    @position == 0b1111_1111_1111_1111
  end
end



class TacticsPosition
  # pretty display for humans (no bits!)
  def to_s
    board = "%016b" % @position
    board.tr!("01", "_X").gsub!("", " ").strip!
    board.gsub!(/(?:[X_] ){4}/, "\\&\n")
    
    if @position == 0b0000_0000_0000_0000
      "\n#{board}"
    else
      "\nThe #{next_player} player moves:\n\n#{board}\n\n"
    end
  end
  
  def winner
    @player
  end
end


# play a game, with perfect play from both sides...
game = TacticsPosition.new

puts game

until game.over?
  game = game.perfect_play

  puts game
end

# and see who won
puts "The #{game.winner} player wins, with perfect play from both sides.\n\n"
