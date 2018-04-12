#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'minitest/autorun'

Sandwich = Struct.new(:taste, :toppings)

class TestSandwich < Minitest::Test
  def test_that_sandwich_is_delicious
    sandwich = Sandwich.new('delicious', [])

    taste = sandwich.taste

    assert_equal('delicious', taste, 'Sandwich is not delicious')
  end
end
