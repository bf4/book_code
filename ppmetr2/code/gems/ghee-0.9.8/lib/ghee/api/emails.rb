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

    module Users
      module Emails
        class Proxy < ::Ghee::ResourceProxy

          def add(emails)
            connection.post(path_prefix, emails).body
          end

          def remove(emails)
            connection.delete(path_prefix) do |req|
              req.body = emails
            end.status == 204
          end
        end
      end
      class Proxy < ::Ghee::ResourceProxy
        def emails
          Ghee::API::Users::Emails::Proxy.new connection, "#{path_prefix}/emails"
        end
      end
    end
  end
end


