#!/usr/bin/ruby -w
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---

NEW_GAME = 0b0000_0000
END_GAME = 0b1111_1111

POSSIBLE_MOVES = [ 1, 2, 3, 4, 6, 7, 8, 12, 14, 15, 16,
                   17, 32, 34, 48, 64, 68, 96, 112, 128,
                   136, 192, 224, 240 ]

# wins_of_first and wins_of_second
$f = $s = 0

# last_move_by - true  for second player
#                false for first  player

def play( state, last_move_by, possible_moves )
    possible_moves.delete_if { |m| state & m != 0 }
    if state != END_GAME
        possible_moves.each do |m|
            play( state | m, ! last_move_by,  possible_moves.clone )
        end
    elsif last_move_by      # last move was by second player
        $f += 1
    else
        $s += 1
    end
end

play( NEW_GAME, true, POSSIBLE_MOVES )

puts "Wins of first  == #{$f}\nWins of second == #{$s}",
     "#{$f < $s ? 'First' : 'Second'} player is bounded to win"
