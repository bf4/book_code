#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
require 'test_helper'

class SqlTemplatesControllerTest < ActionController::TestCase
  setup do
    @sql_template = sql_templates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sql_templates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sql_template" do
    assert_difference('SqlTemplate.count') do
      post :create, sql_template: { body: @sql_template.body, format: @sql_template.format, handler: @sql_template.handler, locale: @sql_template.locale, partial: @sql_template.partial, path: @sql_template.path }
    end

    assert_redirected_to sql_template_path(assigns(:sql_template))
  end

  test "should show sql_template" do
    get :show, id: @sql_template
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sql_template
    assert_response :success
  end

  test "should update sql_template" do
    patch :update, id: @sql_template, sql_template: { body: @sql_template.body, format: @sql_template.format, handler: @sql_template.handler, locale: @sql_template.locale, partial: @sql_template.partial, path: @sql_template.path }
    assert_redirected_to sql_template_path(assigns(:sql_template))
  end

  test "should destroy sql_template" do
    assert_difference('SqlTemplate.count', -1) do
      delete :destroy, id: @sql_template
    end

    assert_redirected_to sql_templates_path
  end
end
