#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'action_dispatch/middleware/session/abstract_store'
require 'rack/session/memcache'

module ActionDispatch
  module Session
    class MemCacheStore < Rack::Session::Memcache
      include Compatibility
      include StaleSessionCheck

      def initialize(app, options = {})
        require 'memcache'
        options[:expire_after] ||= options[:expires]
        super
      end
    end
  end
end
