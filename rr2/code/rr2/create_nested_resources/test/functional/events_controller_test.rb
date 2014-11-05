#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create, :event => @event.attributes
    end

    assert_redirected_to event_path(assigns(:event))
  end

  test "should show event" do
    get :show, :id => @event.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @event.to_param
    assert_response :success
  end

  test "should update event" do
    put :update, :id => @event.to_param, :event => @event.attributes
    assert_redirected_to event_path(assigns(:event))
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, :id => @event.to_param
    end

    assert_redirected_to events_path
  end
end
