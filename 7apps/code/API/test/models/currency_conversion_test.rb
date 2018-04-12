#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
require 'test_helper'

class CurrencyConversionTest < ActiveSupport::TestCase

  setup do
    @conversion_stub = stub_usd_to_nok_request
  end

  teardown do
    reset_http_stubs
  end

  test "can build a conversion from json" do
    json = usd_to_nok_json
    conversion = CurrencyConversion.from_json_string json
    assert_conversion_as_expected conversion
  end

  test "can find a conversion for two currencies" do
    conversion = CurrencyConversion.for "USD", "NOK"
    assert_conversion_as_expected conversion
    assert_requested @conversion_stub
  end

  test "can conveniently do the math for an amount" do
    json = usd_to_nok_json
    conversion = CurrencyConversion.from_json_string json
    assert_equal 680.67, conversion.for_amount(100)
  end

  def assert_conversion_as_expected(conversion)
    assert_match(/USD to NOK/, conversion.name)
    assert_equal("6.8067", conversion.rate)
    assert_equal(6.8067, conversion.numerical_rate)
    assert_equal("USD", conversion.from)
    assert_equal("NOK", conversion.to)
  end

end
