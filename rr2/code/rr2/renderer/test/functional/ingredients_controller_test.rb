#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'test_helper'

class IngredientsControllerTest < ActionController::TestCase
  setup do
    @ingredient = ingredients(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ingredients)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ingredient" do
    assert_difference('Ingredient.count') do
      post :create, ingredient: @ingredient.attributes
    end

    assert_redirected_to ingredient_path(assigns(:ingredient))
  end

  test "should show ingredient" do
    get :show, id: @ingredient.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ingredient.to_param
    assert_response :success
  end

  test "should update ingredient" do
    put :update, id: @ingredient.to_param, ingredient: @ingredient.attributes
    assert_redirected_to ingredient_path(assigns(:ingredient))
  end

  test "should destroy ingredient" do
    assert_difference('Ingredient.count', -1) do
      delete :destroy, id: @ingredient.to_param
    end

    assert_redirected_to ingredients_path
  end
end
