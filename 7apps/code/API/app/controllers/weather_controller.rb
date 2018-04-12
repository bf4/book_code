#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
class WeatherController < ActionController::Base

  def index
    if request.post? and params[:zip]
      redirect_to weather_for_zip_url zip: params[:zip]
    else
      render "weather/index"
    end
  end

  def location
    # uncomment this to simulate slower responses
    # sleep 5.seconds
    @report = WeatherReport.for_location(params["name"])
    render "weather/zip"
  end

  def zip
    @report = WeatherReport.for_zip(params[:zip])
    render "weather/zip"
  end

end
