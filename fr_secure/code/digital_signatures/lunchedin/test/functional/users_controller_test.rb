#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'

class UsersControllerTest < ActionController::TestCase
  tests UsersController
  
  
    test "should create user" do
    post :create, :user => {
      :first_name => 'Juan', 
      :last_name => 'Valdez', 
      :email => 'juan@gmail.com',
      :username => 'juaninamillion', 
      :zip_code => '75024',
      :password => 'hello34', 
      :password_confirmation => 'hello34'
    }
    user = User.find_by_username('juaninamillion')
    assert_not_nil user, assigns(:user).errors.inspect
    assert_response :redirect
    assert_redirected_to user_path(assigns(:user))
  end
  
  
  
  
  test "should not create user with mass assigned role id" do
    post :create, :user => { 
      :username => 'bsmith', 
      :password => 'hello11',
      :password_confirmation => 'hello11',
      :email => 'bob@yahoo.com',
      :zip_code => '75024',
      :first_name => 'Bob',
      :last_name => 'Smith',
      :role_id => 1  
    }
    user = User.find_by_username('bsmith')
    assert_not_nil user, assigns(:user).errors.inspect
    assert_equal 2, user.role_id  
    assert_response :redirect
    assert_redirected_to user_path(user)
    assert_equal @request.session[:user_id], user.id
  end
  
  
  test "should instantiate new user" do
    get :new
    assert assigns(:user)
  end
end
