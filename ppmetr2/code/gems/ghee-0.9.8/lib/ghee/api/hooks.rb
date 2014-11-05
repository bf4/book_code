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


      module Hooks
        class Proxy < ::Ghee::ResourceProxy
          include Ghee::CUD
          
          # Test hook - This will trigger the hook with the 
          # latest push to the current repository. 
          # 
          def test
              connection.post("#{path_prefix}/test").body
          end


        end
      end

      # Gists::Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy
        # Get hooks
        #
        # Returns json
        #
        def hooks(number=nil, params={})
          params = number if number.is_a?Hash
          prefix = (!number.is_a?(Hash) and number) ? "#{path_prefix}/hooks/#{number}" : "#{path_prefix}/hooks"
          Ghee::API::Repos::Hooks::Proxy.new(connection, prefix, params)
        end
      end
    end
  end
end
