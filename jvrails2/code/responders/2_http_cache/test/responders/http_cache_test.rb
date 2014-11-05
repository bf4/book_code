#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
require "test_helper"
class HttpCacheTest < ActionController::TestCase
  tests UsersController

  setup do
    @request.accept = "application/json"
    ActionController::Base.perform_caching = true

    User.create(name: "First", updated_at: Time.utc(2009))
    User.create(name: "Second", updated_at: Time.utc(2008))
  end

  test "responds with last modified using the latest timestamp" do
    get :index
    assert_equal Time.utc(2009).httpdate, @response.headers["Last-Modified"]
    assert_match '"name":"First"', @response.body
    assert_equal 200, @response.status
  end
  test "responds with not modified if request is still fresh" do
    @request.env["HTTP_IF_MODIFIED_SINCE"] = Time.utc(2009, 6).httpdate
    get :index
    assert_equal 304, @response.status
    assert @response.body.blank?
  end

  test "responds with last modified if request is not fresh" do
    @request.env["HTTP_IF_MODIFIED_SINCE"] = Time.utc(2008, 6).httpdate
    get :index
    assert_equal Time.utc(2009).httpdate, @response.headers["Last-Modified"]
    assert_match '"name":"First"', @response.body
    assert_equal 200, @response.status
  end
end
