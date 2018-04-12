#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'webmock/minitest'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def reset_http_stubs
    WebMock.reset!
  end

  def weather_friday_forecast_hash(id)
    weather_friday_forecast_array(id)[0]
  end

  def weather_friday_forecast_array(id)
    json_string = weather_json(id)
    json = JSON.parse json_string
    json["query"]["results"]["channel"]["item"]["forecast"]
  end

  def stub_weather_zip_request(zip)
    stub_request(:get, "http://query.yahooapis.com/v1/public/yql?format=json&q=select%20item%20from%20weather.forecast%20where%20location=%22#{zip}%22").
      to_return(:status => 200, :body => weather_json(zip))
  end

  def stub_weather_location_request(location_id, location_name)
    location_name = URI::encode location_name
    stub_request(:get, "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22#{location_name}%22)&format=json").
      to_return(:status => 200, :body => weather_json(location_id))
  end

  def stub_usd_to_nok_request
    stub_request(:get, "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.xchange%20where%20pair%20in%20(%22USDNOK%22)&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&format=json").
      to_return(:status => 200, :body => usd_to_nok_json)
  end

  def stub_apple_hq_request
    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/reverse?key=KEY&location=37.33233141,-122.0312186").
      to_return(:status => 200, :body => infinite_loop_reverse_geocode)
  end

  def stub_big_three_symbols_request
    stub_request(:get, "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(%22AAPL,GOOG,MSFT%22)&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&format=json").
      to_return(:status => 200, :body => big_three_quotes)
  end

  def stock_quote_for(symbol)
    json_string = big_three_quotes
    json = JSON.parse json_string
    json["query"]["results"]["quote"].find { |quote| quote["symbol"] == symbol }
  end

  def weather_json(id)
    read_json_fixture_file "weather_#{id}"
  end

  def usd_to_nok_json
    read_json_fixture_file "usd_to_nok"
  end

  def infinite_loop_reverse_geocode
    read_json_fixture_file "infinite_loop_reverse_geocode"
  end

  def big_three_quotes
    read_json_fixture_file "big_three_symbols"
  end

  def aapl_quote
    read_json_fixture_file "AAPL_quote"
  end

  def read_json_fixture_file(named)
    File.open "#{Rails.root}/test/fixtures/json/#{named}.json" do |f|
      f.read
    end
  end

end
