#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'
require 'event_controller'

# Re-raise errors caught by the controller.
class EventController; def rescue_action(e) raise e end; end

class EventControllerTest < Test::Unit::TestCase
  def setup
    @controller = EventController.new
    @request    = ActionController::TestRequest.new
    @request.session = { :user_id => 1 }
    @response   = ActionController::TestResponse.new
  end

  
  def test_create
    post :create, :event => { :notes => '', :location => 'Plano' }, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'invite'
    assert_not_nil @request.session[:user_id]
  end
  

end
