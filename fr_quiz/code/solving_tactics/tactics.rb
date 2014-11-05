#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
class Tactics
  # The tactics board is represented as a 16-bit integer,
  # 0s representing empty square; 1s representing filled squares.
  EMPTY, FULL = 0, 0xFFFF

  # Record a WIN or LOSS for potentially each of the 2**16 possible
  # board positions. A position is recorded as a WIN (or LOSS) if
  # that position represents a WIN (or LOSS) to a player prior to
  # moving from that position.
  WIN, LOSS = 1, 0
  (@@position = Array.new(0x10000))[FULL] = WIN

  # Create a new Tactics game, starting at the specified position.
  def initialize(board = EMPTY, possible_moves = Tactics.all_possible_moves)
    @board = board
    @possible_moves = prune_possible_moves(board, possible_moves)
  end

  # Play from the current position. If *any* move guarantees a win,
  # then mark this position as a WIN and return it. Otherwise this
  # position loses.
  def play
    @possible_moves.each do |move|
      new_board = @board | move
      if ( @@position[new_board] ||
           Tactics.new(new_board, @possible_moves).play ) == LOSS then
        return @@position[@board] = WIN 
      end
    end
    @@position[@board] = LOSS
  end

  private

  # Reduce the set of possible moves provided to the actual moves
  # that are possible from the specified starting position.
  def prune_possible_moves(board, possible_moves)
    possible_moves.reject { |move| (board & move) != 0 }
  end
  
  # Compute all possible moves from an empty board.
  def self.all_possible_moves
    # Replicate the possibilities for a single row over each row and column of 
    # the grid.
    (0..3).inject([]) do |moves, row|
      [ 0b1000, 0b0100, 0b0010, 0b0001, 0b1100,
        0b0110, 0b0011, 0b1110, 0b0111, 0b1111 ].each do |bits|
        move = bits << 4 * row
        moves << move << transpose(move)
      end
      moves
    end.uniq
  end

  # Return the transposed board (horizontal to vertical, or vice versa)
  def self.transpose(board)
    (0..15).inject(0) { |xboard, i|
      q,r = i.divmod(4); xboard |= board[i] << q + r*4
    }
  end
end
