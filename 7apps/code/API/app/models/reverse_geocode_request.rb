#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
class ReverseGeocodeRequest

  attr_accessor :place

  def self.for(lat, long)
    url     = URI.parse "http://www.mapquestapi.com/geocoding/v1/reverse?key=#{api_key}&location=#{lat},#{long}"
    request = Net::HTTP::Get.new(url.to_s)
    result  = Net::HTTP.start(url.host, url.port) {|http|
      http.request request
    }

    from_json_string result.body
  end

  def self.from_json_string(json_string)
    json = JSON.parse json_string
    location = json["results"][0]["locations"][0]
    place = "#{location['street']} #{location['adminArea5']} #{location['adminArea3']}"
    ReverseGeocodeRequest.new.tap do |rgr|
      rgr.place = place
    end
  end


  private

  def self.api_key
    Rails.application.secrets.mapquest_api_key
  end

end
