#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
require 'test_helper'

class ReverseGeocodeRequestTest < ActionDispatch::IntegrationTest

  setup do
    @reverse_geocode_stub = stub_apple_hq_request
  end

  teardown do
    reset_http_stubs
  end

  test "we get json from a reverse geocode request" do
    get "/reverse_geocode", { lat: "37.33233141", long: "-122.0312186" },
      { "Accept" => "application/json", "Content-Type" => "application/json" }
    assert_equal 200, status
    json = JSON.parse body
    assert_equal "Infinite Loop Cupertino CA", json["place"]
    assert_requested @reverse_geocode_stub
  end

end
