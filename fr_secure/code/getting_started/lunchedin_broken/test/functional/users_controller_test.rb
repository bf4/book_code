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

  def test_create_user_success
    post :create, :user => {
      :first_name => 'Juan', :last_name => 'Valdez', :email => 'juan@gmail.com',
      :username => 'juaninamillion', :zip_code => '75024',
      :password => 'hello3', :password_confirmation => 'hello3'
    }
    assert_response :redirect
    assert_redirected_to user_path(assigns(:user))
  end
end
