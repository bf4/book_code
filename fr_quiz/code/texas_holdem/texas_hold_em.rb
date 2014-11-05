#!/usr/local/bin/ruby -w
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---


require "enumerator"

Card = Struct.new(:face, :suit)

class Hand
  FACE_ORDER = %w{A K Q J T 9 8 7 6 5 4 3 2}
  HAND_ORDER = [ "Royal Flush", "Straight Flush", "Four of a Kind",
                 "Full House", "Flush", "Straight", "Three of a Kind",
                 "Two Pair", "Pair", "High Card" ]
  # the available orderings for cards in a hand
  ORDERS     = { :suit => lambda { |c, all| c.suit },
                 :high => lambda { |c, all| FACE_ORDER.index(c.face) },
                 :face_count => lambda do |c, all|
                   0 - all.find_all { |o| o.face == c.face }.size
                 end,
                 :suit_count => lambda do |c, all|
                   0 - all.find_all { |o| o.suit == c.suit }.size
                 end }
  
  def initialize( cards )
    @cards   = cards
    @name    = nil  # cache for hand lookup, so we only do it once
  end
  
  def order( *by )
    @cards = @cards.sort_by { |card| by.map { |e| ORDERS[e][card, @cards] } }
  end
  
  def hand
    return nil if @cards.size < 7
    @name ||= HAND_ORDER.find { |hand| send(hand.downcase.tr(" ", "_") + "?") }
  end
end

  

class Hand
  def royal_flush?
    order(:suit_count, :high) and cards =~ /^A(\w)K\1Q\1J\1T\1/
  end
end

  

class Hand
  def straight_flush?
    # it's not possible unless we have a Flush (also orders hand)
    return false unless flush?
    # save the full hand, so we can muck with it and restore it later
    saved_cards = @cards
    # trim hand to the Flush suit only
    @cards = @cards.reject { |card| card.suit != @cards[0].suit }
    # see if there is a Straight in the trimmed hand
    result = straight?
    # restore the hand, but preserve the order
    @cards = (@cards + saved_cards).uniq
    # return whether or not we found a Straight
    result
  end
end

  

class Hand
  def four_of_a_kind?
    order(:face_count, :high) and faces =~ /^(\w)\1\1\1/
  end
  
  def full_house?
    order(:face_count, :high) and faces =~ /^(\w)\1\1(\w)\2/
  end
  
  def flush?
    order(:suit_count, :high) and suits =~ /^(\w)\1\1\1\1/
  end
  
  def straight?
    # sort the cards by unique occurance, then value
    seen = Hash.new(0)
    @cards = @cards.sort_by do |card|
      [(seen[card.face] += 1), ORDERS[:high][card, @cards]]
    end
    # check for the special case, a low ace
    return true if faces =~ /^A5432/
    # walk through all possible Straights and check for match
    3.times do
      FACE_ORDER.each_cons(5) do |cards|
        return true if faces =~ /^#{cards.join}/
      end
      # rotate a card to the end and repeat checks two more times
      @cards << @cards.shift
    end
    # if we get this far, we didn't find one
    false
  end
end

  

class Hand
  def three_of_a_kind?
    order(:face_count, :high) and faces =~ /^(\w)\1\1/
  end
  
  def two_pair?
    order(:face_count, :high) and faces =~ /^(\w)\1(\w)\2/
  end
  
  def pair?
    order(:face_count, :high) and faces =~ /^(\w)\1/
  end
  
  def high_card?
    order(:high)
  end
end

  

class Hand
  def to_s
    [hand, cards.scan(/../).join(" ")].reverse.join(" ").strip
  end

  def rating
    return nil if @cards.size < 7
    # rate hand, then each card in it for breaking ties
    [ 0 - HAND_ORDER.index(hand),
      @cards[0..4].map { |card| 0 - FACE_ORDER.index(card.face) } ]
  end
  
  private
  
  def cards() @cards.map { |card| "#{card.face}#{card.suit}" }.join end
  def faces() cards.scan(/(.)./).flatten.join                       end
  def suits() cards.scan(/.(.)/).flatten.join                       end
end



if __FILE__ == $0
  # read hands
  hands = ARGF.inject(Array.new) do |all, line|
    all << Hand.new(line.strip.split.map { |card| Card.new(*card.split("")) })
  end
  # rank hands, best to worst
  ratings = hands.map { |hand| hand.rating }.compact.sort { |a, b| b <=> a }
  # show results
  puts hands.map { |h| h.rating == ratings[0] ? "#{h} (Winner)" : h }
end

