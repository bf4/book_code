#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'test_helper'

class RecipesControllerTest < ActionController::TestCase
  setup do
    @recipe = recipes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recipes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recipe" do
    assert_difference('Recipe.count') do
      post :create, :recipe => @recipe.attributes
    end

    assert_redirected_to recipe_path(assigns(:recipe))
  end

  test "should show recipe" do
    get :show, :id => @recipe.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @recipe.to_param
    assert_response :success
  end

  test "should update recipe" do
    put :update, :id => @recipe.to_param, :recipe => @recipe.attributes
    assert_redirected_to recipe_path(assigns(:recipe))
  end

  test "should destroy recipe" do
    assert_difference('Recipe.count', -1) do
      delete :destroy, :id => @recipe.to_param
    end

    assert_redirected_to recipes_path
  end
end
