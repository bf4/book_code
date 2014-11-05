#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require File.expand_path(File.join(File.dirname(__FILE__), "..", "helper"))

module Middleware
  class RetryTest < Faraday::TestCase
    def setup
      @stubs = Faraday::Adapter::Test::Stubs.new
      @conn = Faraday.new do |b|
        b.request :retry, 2
        b.adapter :test, @stubs
      end
    end

    def test_retries
      times_called = 0

      @stubs.post("/echo") do
        times_called += 1
        raise "Error occurred"
      end

      @conn.post("/echo") rescue nil
      assert_equal times_called, 3
    end
  end
end
