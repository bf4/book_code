#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'helper'))
require 'stringio'
require 'logger'

module Adapters
  class LoggerTest < Faraday::TestCase
    def setup
      @io     = StringIO.new
      @logger = Logger.new(@io)
      @logger.level = Logger::DEBUG

      @conn = Faraday.new do |b|
        b.response :logger, @logger
        b.adapter :test do |stubs|
          stubs.get('/hello') { [200, {'Content-Type' => 'text/html'}, 'hello'] }
        end
      end
      @resp = @conn.get '/hello', nil, :accept => 'text/html'
    end

    def test_still_returns_output
      assert_equal 'hello', @resp.body
    end

    def test_logs_method_and_url
      assert_match "get http:/hello", @io.string
    end

    def test_logs_request_headers
      assert_match %(Accept: "text/html), @io.string
    end

    def test_logs_response_headers
      assert_match %(Content-Type: "text/html), @io.string
    end
  end
end
