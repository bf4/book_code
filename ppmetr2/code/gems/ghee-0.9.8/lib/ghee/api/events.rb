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

    # The Events module handles all of the Github Event
    # API endpoints
    #
    module Events
      class Proxy < ::Ghee::ResourceProxy
      end

      # Get events
      #
      # Returns json
      #
      def events(params={})
        return Proxy.new(connection, "/events",params)
      end
      
    end
  end
end
