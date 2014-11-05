#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'test_helper'

class WombatsControllerTest < ActionController::TestCase
  setup do
    @wombat = wombats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wombats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wombat" do
    assert_difference('Wombat.count') do
      post :create, :wombat => @wombat.attributes
    end

    assert_redirected_to wombat_path(assigns(:wombat))
  end

  test "should show wombat" do
    get :show, :id => @wombat.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @wombat.to_param
    assert_response :success
  end

  test "should update wombat" do
    put :update, :id => @wombat.to_param, :wombat => @wombat.attributes
    assert_redirected_to wombat_path(assigns(:wombat))
  end

  test "should destroy wombat" do
    assert_difference('Wombat.count', -1) do
      delete :destroy, :id => @wombat.to_param
    end

    assert_redirected_to wombats_path
  end
end
