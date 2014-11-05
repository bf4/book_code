#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'
require 'profile_controller'

# Re-raise errors caught by the controller.
class ProfileController; def rescue_action(e) raise e end; end

class ProfileControllerTest < Test::Unit::TestCase
  def setup
    @controller = ProfileController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  
  def test_create
    post :create, :user => { 
      :user_name => 'bsmith', 
      :password => 'hello1',
      :password_confirmation => 'hello1',
      :email => 'bob@yahoo.com',
      :zip_code => '75024',
      :first_name => 'Bob',
      :last_name => 'Smith',
      :role_id => 1  
    }
    user = User.find_by_user_name('bsmith')
    assert_equal 2, user.role_id  
    assert_response :redirect
    assert_redirected_to :controller => 'profile', :action => 'show', :id => user.id
    assert_equal @request.session[:user_id], user.id
  end
  
  
  def test_my_profile
    @request.session[:user_id] = 2
    get :my_profile
    assert_response :success
    assert_equal 2, assigns['user'].id
  end
end
