#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require File.expand_path('../integration', __FILE__)

module Adapters
  class ExconTest < Faraday::TestCase

    def adapter() :excon end

    Integration.apply(self, :NonParallel) do
      # https://github.com/geemus/excon/issues/126 ?
      undef :test_timeout if ssl_mode?

      # Excon lets OpenSSL::SSL::SSLError be raised without any way to
      # distinguish whether it happened because of a 407 proxy response
      undef :test_proxy_auth_fail if ssl_mode?
    end
  end
end
