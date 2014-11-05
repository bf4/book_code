#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
require 'test/unit'
require 'tactics.rb'

class TestTactics < Test::Unit::TestCase
  # Test the play engine by trying various board positions that we
  # know are winning or losing positions. Each of these is justified
  # (no point in using ones that are just hunches on our part--'cause
  # then what would we be verifying?).
  def test_play
    # Each position description is the position you're faced with
    # just before playing. So "1 square loses" means that if it's
    # your turn to play and there's only one square available,
    # you lose.

    # 1 square loses (obviously)
    assert_equal(Tactics::LOSS, Tactics.new(0b0111_1111_1111_1111).play)
    assert_equal(Tactics::LOSS, Tactics.new(0b1011_1111_1111_1111).play)
    assert_equal(Tactics::LOSS, Tactics.new(0b1101_1111_1111_1111).play)
    assert_equal(Tactics::LOSS, Tactics.new(0b1110_1111_1111_1111).play)
    assert_equal(Tactics::LOSS, Tactics.new(0b1111_0111_1111_1111).play)
    assert_equal(Tactics::LOSS, Tactics.new(0b1111_1011_1111_1111).play)
    assert_equal(Tactics::LOSS, Tactics.new(0b1111_1101_1111_1111).play)
    assert_equal(Tactics::LOSS, Tactics.new(0b1111_1110_1111_1111).play)
    assert_equal(Tactics::LOSS, Tactics.new(0b1111_1111_0111_1111).play)
    assert_equal(Tactics::LOSS, Tactics.new(0b1111_1111_1011_1111).play)
    assert_equal(Tactics::LOSS, Tactics.new(0b1111_1111_1101_1111).play)
    assert_equal(Tactics::LOSS, Tactics.new(0b1111_1111_1110_1111).play)
    assert_equal(Tactics::LOSS, Tactics.new(0b1111_1111_1111_0111).play)
    assert_equal(Tactics::LOSS, Tactics.new(0b1111_1111_1111_1011).play)
    assert_equal(Tactics::LOSS, Tactics.new(0b1111_1111_1111_1101).play)
    assert_equal(Tactics::LOSS, Tactics.new(0b1111_1111_1111_1110).play)

    # 2 squares in a row wins (because you can reduce to one square) 
    assert_equal(Tactics::WIN, Tactics.new(0b0011_1111_1111_1111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1001_1111_1111_1111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1100_1111_1111_1111).play)

    assert_equal(Tactics::WIN, Tactics.new(0b1111_0011_1111_1111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1111_1001_1111_1111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1111_1100_1111_1111).play)

    assert_equal(Tactics::WIN, Tactics.new(0b1111_1111_0011_1111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1111_1111_1001_1111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1111_1111_1100_1111).play)

    assert_equal(Tactics::WIN, Tactics.new(0b1111_1111_1111_0011).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1111_1111_1111_1001).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1111_1111_1111_1100).play)

    assert_equal(Tactics::WIN, Tactics.new(0b0111_0111_1111_1111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1111_0111_0111_1111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1111_1111_0111_0111).play)

    assert_equal(Tactics::WIN, Tactics.new(0b1011_1011_1111_1111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1111_1011_1011_1111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1111_1111_1011_1011).play)

    assert_equal(Tactics::WIN, Tactics.new(0b1101_1101_1111_1111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1111_1101_1101_1111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1111_1111_1101_1101).play)

    assert_equal(Tactics::WIN, Tactics.new(0b1110_1110_1111_1111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1111_1110_1110_1111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1111_1111_1110_1110).play)

    # 3 squares in a row wins (because you can reduce to one square)

    assert_equal(Tactics::WIN, Tactics.new(0b0001_1111_1111_1111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1000_1111_1111_1111).play)

    assert_equal(Tactics::WIN, Tactics.new(0b1111_0001_1111_1111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1111_1000_1111_1111).play)

    assert_equal(Tactics::WIN, Tactics.new(0b1111_1111_0001_1111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1111_1111_1000_1111).play)

    assert_equal(Tactics::WIN, Tactics.new(0b1111_1111_1111_0001).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1111_1111_1111_1000).play)


    assert_equal(Tactics::WIN, Tactics.new(0b0111_0111_0111_1111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1111_0111_0111_0111).play)

    assert_equal(Tactics::WIN, Tactics.new(0b1011_1011_1011_1111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1111_1011_1011_1011).play)


    assert_equal(Tactics::WIN, Tactics.new(0b1101_1101_1101_1111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1111_1101_1101_1101).play)

    assert_equal(Tactics::WIN, Tactics.new(0b1110_1110_1110_1111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1111_1110_1110_1110).play)

    # 4 squares in a row wins (because you can reduce to one square)

    assert_equal(Tactics::WIN, Tactics.new(0b0000_1111_1111_1111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1111_0000_1111_1111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1111_1111_0000_1111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1111_1111_1111_0000).play)

    assert_equal(Tactics::WIN, Tactics.new(0b0111_0111_0111_0111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1011_1011_1011_1011).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1101_1101_1101_1101).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1110_1110_1110_1110).play)

    # 2x2 square loses (because your opponent can always reduce it to one
    # square immediately after your move)
    assert_equal(Tactics::LOSS, Tactics.new(0b0011_0011_1111_1111).play)
    assert_equal(Tactics::LOSS, Tactics.new(0b1111_0011_0011_1111).play)
    assert_equal(Tactics::LOSS, Tactics.new(0b1111_1111_0011_0011).play)

    assert_equal(Tactics::LOSS, Tactics.new(0b1001_1001_1111_1111).play)
    assert_equal(Tactics::LOSS, Tactics.new(0b1111_1001_1001_1111).play)
    assert_equal(Tactics::LOSS, Tactics.new(0b1111_1111_1001_1001).play)

    assert_equal(Tactics::LOSS, Tactics.new(0b1100_1100_1111_1111).play)
    assert_equal(Tactics::LOSS, Tactics.new(0b1111_1100_1100_1111).play)
    assert_equal(Tactics::LOSS, Tactics.new(0b1111_1111_1100_1100).play)

    # 2x3 (or 3x2) rectangle wins (because you can reduce it to a 2x2)
    assert_equal(Tactics::WIN, Tactics.new(0b0011_0011_0011_1111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1001_1001_1001_1111).play)

    assert_equal(Tactics::WIN, Tactics.new(0b1100_1100_1100_1111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1111_0011_0011_0011).play)

    assert_equal(Tactics::WIN, Tactics.new(0b1111_1001_1001_1001).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1111_1100_1100_1100).play)

    assert_equal(Tactics::WIN, Tactics.new(0b0001_0001_1111_1111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1000_1000_1111_1111).play)

    assert_equal(Tactics::WIN, Tactics.new(0b1111_0001_0001_1111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1111_1000_1000_1111).play)

    assert_equal(Tactics::WIN, Tactics.new(0b1111_1111_0001_0001).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1111_1111_1000_1000).play)

    # Now we'll play from an empty board. The purpose of this assertion
    # is just to verify that we get the same answer that we get when
    # the engine is started from scratch. In this case, we have done all the
    # preceding plays--the results of which are stored in the engine.
    assert_equal(Tactics::LOSS, Tactics.new(0b0000_0000_0000_0000).play)

    # Also check that it works the same with the defaulted empty board.
    assert_equal(Tactics::LOSS, Tactics.new.play)

    # Continue with a few random assertions. No attempt to be exhaustive
    # this time. This is deliberately located below the full play, above,
    # to see that intermediate board positions that have been stored
    # are accurate. Of course, this doesn't test very many of them.
    
    # A 2x2 L shape. Trivially reducible to 1 square.
    assert_equal(Tactics::WIN, Tactics.new(0b0011_0111_1111_1111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1111_1011_1001_1111).play)
    
    # A 2x3 L shape. Trivially reducible to 1 square.
    assert_equal(Tactics::WIN, Tactics.new(0b0011_0111_0111_1111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1111_1011_1000_1111).play)
    
    # A 2x4 L shape. Trivially reducible to 1 square.
    assert_equal(Tactics::WIN, Tactics.new(0b0011_0111_0111_0111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1111_0111_0000_1111).play)

    # A 3x4 L shape. Reducible to two lengths of two.
    assert_equal(Tactics::WIN, Tactics.new(0b0001_0111_0111_0111).play)
    assert_equal(Tactics::WIN, Tactics.new(0b0000_0111_0111_1111).play)

    # A checkerboard. Wins as long as the number of open squares is even.
    assert_equal(Tactics::WIN, Tactics.new(0b0101_1010_0101_1010).play)
    assert_equal(Tactics::WIN, Tactics.new(0b1010_0101_1010_0101).play)
  end
end
