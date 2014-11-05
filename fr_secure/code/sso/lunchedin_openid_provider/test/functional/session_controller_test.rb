#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'

class SessionControllerTest < ActionController::TestCase
  tests SessionController

  
  def test_sql_injection
    post :check_login, :user => { 
      :username => "bob' OR 'a' = 'a", 
      :password => "fakepass' OR 'a' = 'a"
    }
    assert_redirected_to :action => 'login', :controller => 'session' 
    assert_nil @request.session[:user_id] 
  end
  
  
  def test_redirect
    
  end
end
