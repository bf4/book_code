#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Ghee
  module API
    module Authorizations
      class Proxy < ::Ghee::ResourceProxy
        include Ghee::CUD
      end

      def authorizations(number=nil)
        prefix = number ? "/authorizations/#{number}" : "/authorizations"
        Ghee::API::Authorizations::Proxy.new(connection, prefix)
      end
    end
  end
end
