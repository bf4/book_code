#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
require 'test_helper'

class WeatherReportRequestTest < ActionDispatch::IntegrationTest

  setup do
    @weather_stub = stub_weather_zip_request(80003)
    @weather_stub_arvada = stub_weather_location_request("arvada", "Arvada, CO")
  end

  teardown do
    reset_http_stubs
  end

  test "we get json from a json request to weather" do
    get "/weather/80003", {}, { "Accept" => "application/json", "Content-Type" => "application/json" }
    assert_equal 200, status
    report = WeatherReport.from_json_string weather_json(80003)
    assert_equal report.to_json, body
    assert_requested @weather_stub
  end

  test "we get json from a json request for weather at a location" do
    get "/weather/location?name=Arvada,%20CO", {}, { "Accept" => "application/json", "Content-Type" => "application/json" }
    assert_equal 200, status
    report = WeatherReport.from_json_string weather_json("arvada")
    assert_equal report.to_json, body
    assert_requested @weather_stub_arvada
  end

end
