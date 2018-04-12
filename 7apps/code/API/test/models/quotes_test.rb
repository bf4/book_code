#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
require 'test_helper'

class QuotesTest < ActiveSupport::TestCase

  test "can build a stock quote from json hash" do
    hash = stock_quote_for("AAPL")
    quote = StockQuote.from_hash hash
    assert_equal("AAPL", quote.symbol)
    assert_equal("Apple Inc.", quote.name)
    assert_equal("114.76", quote.ask)
    assert_equal("114.44", quote.bid)
    assert_equal("-0.29", quote.change)
    assert_equal("-0.25%", quote.percent_change)
    assert_equal("USD", quote.currency)
    assert_equal("9/25/2015", quote.last_trade_date)
    assert_equal("4:00pm", quote.last_trade_time)
    assert_equal("114.71", quote.last_trade_price_only)
    assert_equal("77.88B", quote.ebitda)
    assert_equal("116.36", quote.open)
    assert_equal("NMS", quote.stock_exchange)
    assert_equal("654.16B", quote.market_capitalization)
    assert_equal(true, quote.is_down)
  end

  test "can load a list of quotes from yahoo json" do
    quotes = StockQuote.list_from_json_string big_three_quotes
    assert_equal(3, quotes.size)
  end

  test "can load a list from a single quote from yahoo json" do
    quotes = StockQuote.list_from_json_string aapl_quote
    assert_equal(1, quotes.size)
  end

end
