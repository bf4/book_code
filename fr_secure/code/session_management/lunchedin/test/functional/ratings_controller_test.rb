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
  
  
  test "should not rate if using get" do
    @request.session[:user_id] = users(:bob).id
    xhr :get, :rate, :id => venues(:micos).id, :score => 1
    assert_response 400
  end
  

  
  test "should rate positively using post" do
    @request.session[:user_id] = users(:bob).id
    xhr :post, :rate, :id => venues(:micos).id, :score => 1
    assert_response :success
  end
  
  
  
  test "should rate negatively using post" do
    @request.session[:user_id] = users(:bob).id
    xhr :post, :rate, :id => venues(:micos).id, :score => 0
    assert_response :success
  end  
  
  
end
