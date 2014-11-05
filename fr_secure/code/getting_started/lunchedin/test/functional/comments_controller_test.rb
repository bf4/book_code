#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'

class CommentsControllerTest < ActionController::TestCase
  tests CommentsController

  def test_create_comment_xhr_success
    @request.session[:user_id] = 1
    xhr :post, :create, :venue_id => 1, :comment => {
      :subject => 'Try the Spinach', :body => 'You won\'t find any better'}
    assert_response :success
  end
  
  # TODO finish example showing a failure of adding insecure input to a comment
  def test_create_with_insecure_input
    
  end
end
