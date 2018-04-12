#---
# Excerpted from "Agile Web Development with Rails 5.1",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rails51 for more book information.
#---
require 'test_helper'

class CartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cart = carts(:one)
  end

  test "should get index" do
    get carts_url
    assert_response :success
  end

  test "should get new" do
    get new_cart_url
    assert_response :success
  end

  test "should create cart" do
    assert_difference('Cart.count') do
      post carts_url, params: { cart: {  } }
    end

    assert_redirected_to cart_url(Cart.last)
  end

  test "should show cart" do
    get cart_url(@cart)
    assert_response :success
  end

  test "should get edit" do
    get edit_cart_url(@cart)
    assert_response :success
  end

  test "should update cart" do
    patch cart_url(@cart), params: { cart: {  } }
    assert_redirected_to cart_url(@cart)
  end

  test "should destroy cart" do
    post line_items_url, params: { product_id: products(:ruby).id }
    @cart = Cart.find(session[:cart_id])

    assert_difference('Cart.count', -1) do
      delete cart_url(@cart)
    end

    assert_redirected_to store_index_url
  end
end
