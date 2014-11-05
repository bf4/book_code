#!/usr/local/bin/ruby -w
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---

require "yaml"

class CipherDeck
  DEFAULT_MAPPING = Hash[ *( (0..51).map { |n| [n +1, (?A + n % 26).chr] } +
                           ["A", :skip, "B", :skip] ).flatten ]
  
  def initialize( cards = nil, &keystream_generator )
    @cards = if cards and File.exists? cards
      File.open(cards) { |file| YAML.load(file) }
    else
      (1..52).to_a << "A" << "B"
    end
    @keystream_generator = keystream_generator
  end
  
  def count_cut( counter = :bottom )
    count = counter_to_count(counter)
    @cards = @cards.values_at(count..52, 0...count, 53)
  end
  
  def count_to_letter( counter = :top, mapping = DEFAULT_MAPPING )
    card = @cards[counter_to_count(counter)]
    mapping[card] or raise ArgumentError, "Card not found in mapping."
  end
  
  def move_down( card )
    if card == @cards.last
      @cards[1, 0] = @cards.pop
    else
      index = @cards.index(card)
      @cards[index], @cards[index + 1] = @cards[index + 1], @cards[index]
    end
  end
  
  def next_letter( &keystream_generator )
    if not keystream_generator.nil?
      keystream_generator[self]
    elsif not @keystream_generator.nil?
      @keystream_generator[self]
    else
      raise ArgumentError, "Keystream generation process not given."
    end
  end
  
  def save( filename )
    File.open(filename, "w") { |file| YAML.dump(@cards, file) }
  end
  
  def triple_cut( first_card = "A", second_card = "B" )
    first, second = @cards.index(first_card), @cards.index(second_card)
    top,   bottom = [first, second].sort
    @cards = @cards.values_at((bottom + 1)..53, top..bottom, 0...top)
  end
  
  def to_a
    @cards.inject(Array.new) do |arr, card|
      arr << if card.is_a? String then card.dup else card end
    end
  end
  
  private
  
  def counter_to_count( counter )
    unless counter = {:top => :first, :bottom => :last}[counter]
      raise ArgumentError, "Counter must be :top or :bottom."
    end
    count = @cards.send(counter)
    if count.is_a? String then 53 else count end
  end
end
