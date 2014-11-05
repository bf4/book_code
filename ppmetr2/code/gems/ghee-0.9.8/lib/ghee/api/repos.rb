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

      # Gists::Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy
        attr_accessor :repo_name
      end

      # Get repos
      #
      # name - String of the name of the repo
      #
      # Returns json
      #
      def repos(login,name = nil)
        repo = name.nil? ? login : "#{login}/#{name}"
        path_prefix = "/repos/#{repo}"
        proxy = Proxy.new(connection, path_prefix)
        proxy.repo_name = repo
        proxy
      end

    end
  end
end
