#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'

class DbUserTest < ActiveSupport::TestCase
  
  def test_find_and_authenticate_success
    assert User.find_and_authenticate('wally', "newpass1")
  end
  
  def test_authentic_failed
    assert !User.find_and_authenticate('wally', 'foo')
  end
  
  def test_authentic
    assert users(:wally).authentic?("newpass1")
  end
  
end

