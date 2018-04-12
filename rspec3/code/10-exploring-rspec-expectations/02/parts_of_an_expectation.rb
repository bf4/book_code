#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
# validate me
require 'rspec/expectations'
include RSpec::Matchers

class Deck
  def cards
    @cards ||= Array.new(52)
  end
end

deck = Deck.new
expect(deck.cards.count).to eq(52), 'not playing with a full deck'
