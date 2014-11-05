#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'

class UserTest < Test::Unit::TestCase
  fixtures :users

  def test_salts
    assert(users(:bob).salt == "salt1234567890", "Expecting salt1234567890.  Was #{users(:bob).salt}")
    assert(users(:dave).salt == "salt1234567890", "Expecting salt1234567890.  Was #{users(:dave).salt}")    
    assert(users(:bob).password == Digest::SHA1.hexdigest("#{users(:bob).salt}hello"))
    assert(users(:dave).password == Digest::SHA1.hexdigest("#{users(:dave).salt}hello"))    
  end
end
