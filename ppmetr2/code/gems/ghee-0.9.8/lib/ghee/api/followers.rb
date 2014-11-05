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
      class Proxy < ::Ghee::ResourceProxy
        def followers
          connection.get("#{path_prefix}/followers").body
        end
        def following
          connection.get("#{path_prefix}/following").body
        end
        def following?(user)
          connection.get("#{path_prefix}/following/#{user}").status == 204
        end
        def follow(user)
          connection.put("#{path_prefix}/following/#{user}").status == 204
        end
        def follow!(user)
          connection.delete("#{path_prefix}/following/#{user}").status == 204
        end
      end
    end
  end
end



