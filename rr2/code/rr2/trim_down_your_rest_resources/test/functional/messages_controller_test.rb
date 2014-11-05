#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  setup do
    @message = messages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:messages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create message" do
    assert_difference('Message.count') do
      post :create, :message => @message.attributes
    end

    assert_redirected_to message_path(assigns(:message))
  end

  test "should show message" do
    get :show, :id => @message.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @message.to_param
    assert_response :success
  end

  test "should update message" do
    put :update, :id => @message.to_param, :message => @message.attributes
    assert_redirected_to message_path(assigns(:message))
  end

  test "should destroy message" do
    assert_difference('Message.count', -1) do
      delete :destroy, :id => @message.to_param
    end

    assert_redirected_to messages_path
  end
end
