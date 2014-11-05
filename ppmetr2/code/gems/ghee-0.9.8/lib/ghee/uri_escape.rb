#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Ghee
  module Middleware
    class UriEscape < Faraday::Middleware
      def call(env)
        env[:url] = URI.parse(URI.escape(env[:url].to_s))
        @app.call(env)
      end
    end
  end
end
