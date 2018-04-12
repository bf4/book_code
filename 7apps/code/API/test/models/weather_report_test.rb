#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
require 'test_helper'

class WeatherReportTest < ActiveSupport::TestCase

  setup do
    @weather_stub_80003 = stub_weather_zip_request(80003)
    @weather_stub_arvada = stub_weather_location_request("arvada", "Arvada, CO")
  end

  teardown do
    reset_http_stubs
  end

  test "can build a report from json" do
    json = weather_json(80003)
    report = WeatherReport.from_json_string json
    assert_zip_report_as_expected report
  end

  test "can find weather report for a zip code" do
    report = WeatherReport.for_zip "80003"
    assert_zip_report_as_expected report
    assert_requested @weather_stub_80003
  end

  test "can find weather report for a location name" do
    report = WeatherReport.for_location "Arvada, CO"
    assert_match(/Conditions for Arvada/, report.title)
    assert_equal("59", report.temp)
    assert_equal("Partly Cloudy/Windy", report.current_conditions)
    assert_equal("Sat, 07 Feb 2015 6:55 pm MST", report.date)
    assert_equal(5, report.forecasts.size)
    assert_requested @weather_stub_arvada
  end

  def assert_zip_report_as_expected(report)
    assert_match(/Conditions for Arvada/, report.title)
    assert_equal("54", report.temp)
    assert_equal("Partly Cloudy", report.current_conditions)
    assert_equal("Fri, 21 Nov 2014 10:49 am MST", report.date)
    assert_equal(5, report.forecasts.size)
  end

end
