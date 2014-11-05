#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'

class VenueTest < Test::Unit::TestCase
  fixtures :venues, :ratings

  def test_add_tag
    assert true
  end
  
  def test_rating
    assert_equal 0.8, Venue.find(1).rating
  end
  
  def test_positive_ratings
    assert_equal 8, Venue.find(1).positive_ratings
  end  
end