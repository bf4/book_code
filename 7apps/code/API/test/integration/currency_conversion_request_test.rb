#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
require 'test_helper'

class CurrencyConversionRequestTest < ActionDispatch::IntegrationTest

  setup do
    @conversion_stub = stub_usd_to_nok_request
  end

  teardown do
    reset_http_stubs
  end

  test "we get json from a json request to weather" do
    get "/convert/USD/NOK", {}, { "Accept" => "application/json", "Content-Type" => "application/json" }
    assert_equal 200, status
    conversion = CurrencyConversion.from_json_string usd_to_nok_json
    json = JSON.parse body
    assert_equal json["name"], conversion.name
    assert_equal json["rate"], conversion.rate
    assert_equal json["from"], conversion.from
    assert_equal json["to"], conversion.to
    assert_requested @conversion_stub
  end

end
