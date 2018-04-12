#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
class WeatherReport

  attr_accessor :title, :temp, :current_conditions, :date, :forecasts

  def self.for_zip(zip)
    url     = URI.parse "http://query.yahooapis.com/v1/public/yql?q=select%20item%20from%20weather.forecast%20where%20location%3D%22#{zip}%22&format=json"
    self.report_from_url(url)
  end

  def self.for_location(location)
    location = URI::encode location
    url = URI.parse "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22#{location}%22)&format=json"
    self.report_from_url(url)
  end

  def self.report_from_url(url)
    request = Net::HTTP::Get.new(url.to_s)
    result  = Net::HTTP.start(url.host, url.port) {|http|
      http.request request
    }

    self.from_json_string result.body
  end

  def self.from_json_string(json_string)
    json = JSON.parse json_string
    item = json["query"]["results"]["channel"]["item"]
    conditions = item["condition"]
    forecasts = item["forecast"]
    self.new.tap do |r|
      r.title               = item["title"]
      r.temp                = conditions["temp"]
      r.current_conditions  = conditions["text"]
      r.date                = conditions["date"]
      r.forecasts           = forecasts.map do |forecast_hash|
        Forecast.from_hash(forecast_hash)
      end
    end
  end

end
