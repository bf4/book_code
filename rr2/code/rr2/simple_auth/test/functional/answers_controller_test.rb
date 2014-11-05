#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'test_helper'

class AnswersControllerTest < ActionController::TestCase
  setup do
    @answer = answers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:answers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create answer" do
    assert_difference('Answer.count') do
      post :create, :answer => @answer.attributes
    end

    assert_redirected_to answer_path(assigns(:answer))
  end

  test "should show answer" do
    get :show, :id => @answer.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @answer.to_param
    assert_response :success
  end

  test "should update answer" do
    put :update, :id => @answer.to_param, :answer => @answer.attributes
    assert_redirected_to answer_path(assigns(:answer))
  end

  test "should destroy answer" do
    assert_difference('Answer.count', -1) do
      delete :destroy, :id => @answer.to_param
    end

    assert_redirected_to answers_path
  end
end
