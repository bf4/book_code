#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'

class RatingsControllerTest < ActionController::TestCase
  tests RatingsController

  
  def test_rate_positively
    @request.session[:user_id] = 1
    xhr :get, :rate, :id => 1, :score => 1
    assert_response :success
  end
  
  
  
  def test_rate_negatively
    @request.session[:user_id] = 1
    xhr :get, :rate, :id => 1, :score => 0
    assert_response :success
  end  
  
  
end
