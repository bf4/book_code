#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'test_helper'

class MeetingsControllerTest < ActionController::TestCase
  setup do
    @meeting = meetings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:meetings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create meeting" do
    assert_difference('Meeting.count') do
      post :create, meeting: @meeting.attributes
    end

    assert_redirected_to meeting_path(assigns(:meeting))
  end

  test "should show meeting" do
    get :show, id: @meeting.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @meeting.to_param
    assert_response :success
  end

  test "should update meeting" do
    put :update, id: @meeting.to_param, meeting: @meeting.attributes
    assert_redirected_to meeting_path(assigns(:meeting))
  end

  test "should destroy meeting" do
    assert_difference('Meeting.count', -1) do
      delete :destroy, id: @meeting.to_param
    end

    assert_redirected_to meetings_path
  end
end
