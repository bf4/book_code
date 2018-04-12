#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
class CurrencyConversion

  attr_accessor :name, :rate, :numerical_rate

  def self.for(from_currency, to_currency)
    url     = URI.parse "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.xchange%20where%20pair%20in%20(%22#{from_currency}#{to_currency}%22)&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&format=json"
    request = Net::HTTP::Get.new(url.to_s)
    result  = Net::HTTP.start(url.host, url.port) {|http|
      http.request request
    }

    CurrencyConversion.from_json_string result.body
  end

  def from
    name.nil? ? nil : name.first(3)
  end

  def to
    name.nil? ? nil : name.last(3)
  end

  def self.from_json_string(json_string)
    json = JSON.parse json_string
    item = json["query"]["results"]["rate"]
    CurrencyConversion.new.tap do |cc|
      cc.name           = item["Name"]
      cc.rate           = item["Rate"]
      cc.numerical_rate = cc.rate.to_f.round(4)
    end
  end

  def for_amount(amount)
    (self.numerical_rate * amount.to_f).round(2)
  end

end
