#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require File.dirname(__FILE__) + '/test_helper'

class SeleniumSupportTest < Test::Unit::TestCase  
  def setup
    @controller = SeleniumController.new
    @controller.extend(SeleniumOnRails::PathsTestHelper)
    ActionController::Routing::Routes.draw
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end
  
  def test_route
    get :support_file, :filename => 'TestRunner.html' #initialize the controller
    assert_equal 'http://test.host/selenium/TestRunner.html', 
        @controller.url_for(:controller => 'selenium', :action => 'support_file', :filename => 'TestRunner.html')
  end
  
  def test_test_runner_existance
    get :support_file, :filename => 'TestRunner.html'
    assert_response :success
    assert @response.body.include?('Selenium')
  end
  
  def test_default_file
    get :support_file, :filename => ''
    assert_redirected_to :filename => 'TestRunner.html', :test => 'tests'
  end
    
  def test_missing_file
    get :support_file, :filename => 'missing.html'
    assert_response 404
    assert_equal 'Not found', @response.body
  end
     
end
