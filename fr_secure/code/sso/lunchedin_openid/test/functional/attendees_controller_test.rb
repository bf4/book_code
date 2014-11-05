#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'

class AttendeesControllerTest < ActionController::TestCase
  tests AttendeesController

  def test_create_attendee_authorized
    @request.session[:user_id] = 3
    xhr :post, :create, :event_id => 1, :attendee => { 
      :email => 'ben@yahoo.com',
      :first_name => 'Ben Poweski'
    }
    #assert assigns(:attendee)
  end
  
  def test_remove_attendee_authorized
    @request.session[:user_id] = 3
    xhr :delete, :destroy, :event_id => 1, :id => 1
    assert assigns(:attendee)
  end  
  
  def test_create_attendee_unauthorized
    @request.session[:user_id] = 1
  end  
end
