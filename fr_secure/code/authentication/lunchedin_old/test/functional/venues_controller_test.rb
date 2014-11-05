#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'
require 'venues_controller'

# Re-raise errors caught by the controller.
class VenuesController; def rescue_action(e) raise e end; end

class VenuesControllerTest < Test::Unit::TestCase
  def setup
    @controller = VenuesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @request.session[:user_id] = 1
  end

  def test_create
    post :create, :venue => {
      :name => 'Taco Diner', :address_one => '7001 Parkwood',
      :city => 'Plano', :state => 'TX', :zip_code => '75024'}
    venue = Venue.find_by_name('Taco Diner')
    assert_not_nil venue
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => venue.id
  end
  
  def test_add_comment
    v = Venue.find(2)
    post :comment, :id => v.id, :comment => {
      :subject => 'Tasty Subs', :body => 'I love eating here!'}
    assert_equal 1, v.comments.length
    assert_equal 'Tasty Subs', v.comments.first.subject
    assert_equal 'Venue', v.comments.first.commentable_type
    assert_equal v.id, v.comments.first.commentable_id
    assert_equal @request.session[:user_id], v.comments.first.user_id
  end
  
  # assert input validation flaw exists
  
  
  def test_add_tag
    v = Venue.find(2)
    post :add_tag, :id => v.id, :tag => 'shakes'
    assert_response :success
    assert_equal 1, v.tags.length
    assert_equal 'shakes', v.tags.first.name
  end
  
  def test_prevent_duplicate_tags
    v = Venue.find(2)
    post :add_tag, :id => v.id, :tag => 'shakes'
    assert_response :success    
    post :add_tag, :id => v.id, :tag => 'shakes'
    assert_equal 1, v.tags.length
  end  
  
  
  def test_rate_positive
    v = Venue.find(2)
    post :rate, :id => v.id, :score => 1
    assert_equal 1, v.ratings.length
    
    # should fail
    post :rate, :id => v.id, :score => 1    
    assert_equal 1, v.ratings.length
  end
  
  
  
  def test_rate_negative
    v = Venue.find(2)
    post :rate, :id => v.id, :score => 0
    assert_equal 1, v.ratings.length
    
    # should fail
    post :rate, :id => v.id, :score => 0
    assert_equal 1, v.ratings.length    
  end  
  
end
