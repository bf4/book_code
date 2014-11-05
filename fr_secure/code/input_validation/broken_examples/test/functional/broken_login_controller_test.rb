#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'
require 'broken_login_controller'

# Re-raise errors caught by the controller.
class BrokenLoginController; def rescue_action(e) raise e end; end

class BrokenLoginControllerTest < Test::Unit::TestCase
  def setup
    @controller = BrokenLoginController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end
  
  
  def test_intended_use_case_success
    post :verify, :email => 'test@yahoo.com', :password => 'hello1'
    assert_redirected_to :action => 'success'    
  end
  

  
  def test_intended_use_case_failure
    post :verify, :email => 'hacker@yahoo.com', :password => 'mypass'
    assert_redirected_to :action => 'failure'
  end
  
  
  
  def test_sql_injection
    post :verify, :email => "hacker@yahoo.com' OR 'a' = 'a", :password => "mypass' OR 'a' = 'a"
    assert_redirected_to :action => 'success'    
  end
  
  
end
