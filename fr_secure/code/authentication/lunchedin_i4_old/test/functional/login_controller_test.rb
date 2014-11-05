#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'
require 'login_controller'

# Re-raise errors caught by the controller.
class LoginController; def rescue_action(e) raise e end; end

class LoginControllerTest < Test::Unit::TestCase
  
  fixtures :users
  
  def setup
    @controller = LoginController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  
  def test_login_success
    post :check_login, :user => { :user_name => 'bob', :password => 'hello' }
    assert_response :redirect
    assert_redirected_to :controller => 'profile', :action => 'show', :id => users(:bob).id
    assert_not_nil @request.session[:user_id]
    assert_equal users(:bob).id, @request.session[:user_id]
  end
  
  
  
  def test_login_failure
    post :check_login, :user => { :user_name => 'bob', :password => 'hello1' }
    assert_response :redirect
    assert_redirected_to :action => 'login', :controller => 'login'
    assert_nil @request.session[:user_id]
  end
  
    
  
  def test_sql_injection
    post :check_login, :user => { 
      :user_name => "bob' OR 'a' = 'a", 
      :password => "fakepass' OR 'a' = 'a"
    }
    assert_redirected_to :action => 'login', :controller => 'login' 
    assert_nil @request.session[:user_id] 
  end
  
end
