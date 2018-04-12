#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
require 'test_helper'

class StockQuoteRequestTest < ActionDispatch::IntegrationTest

  setup do
    @quote_stub = stub_big_three_symbols_request
  end

  teardown do
    reset_http_stubs
  end

  test "we get quotes from the stock endpoint" do
    get "/stock_quotes/AAPL,GOOG,MSFT", {}, { "Accept" => "application/json", "Content-Type" => "application/json" }
    assert_equal 200, status
    list = StockQuote.list_from_json_string big_three_quotes
    json = JSON.parse body
    assert_equal json["quotes"].size, list.size
    assert_equal json["quotes"][0]["name"], list[0].name
    assert_equal json["quotes"][1]["name"], list[1].name
    assert_equal json["quotes"][2]["name"], list[2].name
    assert_requested @quote_stub
  end

end
