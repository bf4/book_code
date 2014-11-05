#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require "#{File.dirname(__FILE__)}/../test_helper"

class AttackVotingLinkTest < ActionController::IntegrationTest
  fixtures :users, :venues, :ratings

  
  def test_double_vote
    get '/venues'
    assert_response :redirect
    assert_redirected_to :controller => 'session'
    https!
    post_via_redirect '/session/check_login',
      :user => { :username => 'bob', :password => 'hello' }
    assert_response :success
    assert_template 'show'
    get_via_redirect venue_path(2)

    assert_response :success
    assert_template 'show'
    
    assert_difference 'Venue.find(2).ratings.count' do
      xhr :post, '/ratings/rate/2?score=1'
    end
    
    # try to post again
    assert_no_difference 'Venue.find(2).ratings.count' do
      xhr :post, '/ratings/rate/2?score=1'
    end
  end
  
end
