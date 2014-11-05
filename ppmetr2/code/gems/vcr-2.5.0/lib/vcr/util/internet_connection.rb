#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module VCR
  # Ruby 1.8 provides Ping.pingecho, but it was removed in 1.9.
  # So we try requiring it, and if that fails, define it ourselves.
  begin
    require 'ping'
    Ping = ::Ping
  rescue LoadError
    # This is copied, verbatim, from Ruby 1.8.7's ping.rb.
    require 'timeout'
    require "socket"

    # @private
    module Ping
      def pingecho(host, timeout=5, service="echo")
        begin
          timeout(timeout) do
            s = TCPSocket.new(host, service)
            s.close
          end
        rescue Errno::ECONNREFUSED
          return true
        rescue Timeout::Error, StandardError
          return false
        end
        return true
      end
      module_function :pingecho
    end
  end

  # @private
  module InternetConnection
    extend self

    EXAMPLE_HOST = "example.com"

    def available?
      @available = VCR::Ping.pingecho(EXAMPLE_HOST, 1, 80) unless defined?(@available)
      @available
    end
  end
end

