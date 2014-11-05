#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'

class TagsControllerTest < ActionController::TestCase
  tests TagsController

  # Replace this with your real tests.
  def test_create
    @request.session[:user_id] = 1
    xhr :post, :create, :venue_id => 1, :tag => 'hamburger'
    assert_response :success
    assert assigns(:venue)
  end
end
