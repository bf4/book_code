#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Repos module handles all of the Github Repo
    # API endpoints
    #
    module Repos

      module Keys
        class Proxy < ::Ghee::ResourceProxy
          include Ghee::CUD
        end
      end

      # Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy

        def keys(id=nil)
          prefix = id ? "#{path_prefix}/keys/#{id}" : "#{path_prefix}/keys"
          Ghee::API::Repos::Keys::Proxy.new connection, prefix
        end
      end
    end
    # The Users module handles all of the Github Repo
    # API endpoints
    #
    module Users

      module Keys
        class Proxy < ::Ghee::ResourceProxy
          include Ghee::CUD
        end
      end

      # Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy

        def keys(id=nil)
          prefix = id ? "#{path_prefix}/keys/#{id}" : "#{path_prefix}/keys"
          Ghee::API::Users::Keys::Proxy.new connection, prefix
        end
      end
    end
  end
end



