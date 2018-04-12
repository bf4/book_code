#---
# Excerpted from "Seven Mobile Apps in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
#---
class StockQuote
  Keys = %w{ Name PercentChange symbol Ask Bid Change Open StockExchange LastTradePriceOnly LastTradeTime LastTradeDate EBITDA MarketCapitalization Currency }

  Keys.each do |key|
    attr_accessor key.underscore
  end

  attr_accessor :is_down

  def self.for(symbol_list)
    symbol_list = CGI.escape symbol_list
    url     = URI.parse "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(%22#{symbol_list}%22)&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&format=json"
    request = Net::HTTP::Get.new(url.to_s)
    result  = Net::HTTP.start(url.host, url.port) {|http|
      http.request request
    }

    StockQuote.list_from_json_string result.body
  end

  def self.list_from_json_string(string)
    json = JSON.parse string
    count = json["query"]["count"]
    if count == 1
      single = json["query"]["results"]["quote"]
      [StockQuote.from_hash(single)]
    else
      list = json["query"]["results"]["quote"]
      list.map do |hash|
        StockQuote.from_hash hash
      end
    end
  end

  def self.from_hash(hash)
    StockQuote.new.tap do |q|
      Keys.each do |key|
        atrr = "#{key.underscore.to_sym}="
        q.send(atrr, hash[key])
      end
      q.is_down = q.change.start_with? "-"
    end
  end

end
