#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
require 'test_helper'

class ForecastTest < ActiveSupport::TestCase

  test "can build a report from json" do
    hash = weather_friday_forecast_hash(80003)
    forecast = Forecast.from_hash hash
    assert_equal("21 Nov 2014", forecast.date)
    assert_equal("Fri", forecast.day)
    assert_equal("49", forecast.high)
    assert_equal("28", forecast.low)
    assert_match("Sunny", forecast.text)
  end

end
