#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
# validate me
require 'timeout'

class StockTicker
  attr_reader :nasdaq_client

  def initialize(nasdaq_client)
    @nasdaq_client = nasdaq_client
    @error_count = 0
  end

  def price(stock_name)
    return nil if @error_count >= 3
    nasdaq_client.current_price(stock_name)
  rescue Timeout::Error
    @error_count += 1
    nil
  end

  def inspect
    '#<StockTicker>'
  end
end

require 'rspec/mocks/standalone'

client = instance_double('NasdaqClient')
expect(client).to receive(:current_price).thrice.and_raise(Timeout::Error)
stock_ticker = StockTicker.new(client)
100.times { stock_ticker.price('AAPL') }

RSpec::Mocks.verify

expect(client).to receive(:current_price).exactly(4).times

expect(client).to receive(:current_price).at_least(3).times
expect(client).to receive(:current_price).at_most(10).times

expect(client).to receive(:current_price).at_least(:once)
expect(client).to receive(:current_price).at_most(:thrice)
