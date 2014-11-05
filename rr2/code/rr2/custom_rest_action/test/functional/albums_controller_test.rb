#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'test_helper'

class AlbumsControllerTest < ActionController::TestCase
  setup do
    @album = albums(:one)
  end
  
  test "should be able to copy an album" do
    assert_difference "Album.count" do
      post :copy, :id => @album.id
      assert_equal @album.title, assigns(:album).title
      assert_not_nil flash[:notice]
      assert_response :redirect
    end
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:albums)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create album" do
    assert_difference('Album.count') do
      post :create, :album => @album.attributes
    end

    assert_redirected_to album_path(assigns(:album))
  end

  test "should show album" do
    get :show, :id => @album.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @album.to_param
    assert_response :success
  end

  test "should update album" do
    put :update, :id => @album.to_param, :album => @album.attributes
    assert_redirected_to album_path(assigns(:album))
  end

  test "should destroy album" do
    assert_difference('Album.count', -1) do
      delete :destroy, :id => @album.to_param
    end

    assert_redirected_to albums_path
  end
end
