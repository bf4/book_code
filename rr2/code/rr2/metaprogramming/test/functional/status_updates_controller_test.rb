#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'test_helper'

class StatusUpdatesControllerTest < ActionController::TestCase
  setup do
    @status_update = status_updates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:status_updates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create status_update" do
    assert_difference('StatusUpdate.count') do
      post :create, :status_update => @status_update.attributes
    end

    assert_redirected_to status_update_path(assigns(:status_update))
  end

  test "should show status_update" do
    get :show, :id => @status_update.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @status_update.to_param
    assert_response :success
  end

  test "should update status_update" do
    put :update, :id => @status_update.to_param, :status_update => @status_update.attributes
    assert_redirected_to status_update_path(assigns(:status_update))
  end

  test "should destroy status_update" do
    assert_difference('StatusUpdate.count', -1) do
      delete :destroy, :id => @status_update.to_param
    end

    assert_redirected_to status_updates_path
  end
end
