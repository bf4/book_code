#---
# Excerpted from "Working with Unix Processes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsunix for more book information.
#---
require 'helper'
require 'excon'

class BasicRackTest < MiniTest::Unit::TestCase
  def setup
    spyglass
  end
  
  def test_it_responds
    response = Excon.get("http://0.0.0.0:#{PORT}/fuzzy")
    
    assert_equal 200, response.status, "Didn't get the right response code"
    assert_match /Hello world/, response.body, "Didn't get the right response body"
  end
end
