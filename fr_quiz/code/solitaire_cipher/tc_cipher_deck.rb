#!/usr/local/bin/ruby -w
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---

require "test/unit"

require "cipher_deck"

class TestCipherDeck < Test::Unit::TestCase
  def setup
    @deck = CipherDeck.new do |deck|
      loop do
        deck.move_down("A")
        2.times { deck.move_down("B") }
        deck.triple_cut
        deck.count_cut
        letter = deck.count_to_letter
      
        break letter if letter != :skip
      end
    end
  end
  
  def test_move_down
    @deck.move_down("A")
    assert_equal((1..52).to_a << "B" << "A", @deck.to_a)
    
    2.times { @deck.move_down("B") }
    assert_equal([1, "B", (2..52).to_a, "A"].flatten, @deck.to_a)
  end
  
  def test_triple_cut
    test_move_down
    
    @deck.triple_cut
    assert_equal(["B", (2..52).to_a, "A", 1].flatten, @deck.to_a)
  end
  
  def test_count_cut
    test_triple_cut
    
    @deck.count_cut
    assert_equal([(2..52).to_a, "A", "B", 1].flatten, @deck.to_a)
  end
  
  def test_count_to_letter
    test_count_cut
    
    assert_equal("D", @deck.count_to_letter)
  end
  
  def test_keystream_generation
    %w{D W J X H Y R F D G}.each do |letter|
      assert_equal(letter, @deck.next_letter)
    end
  end
end
