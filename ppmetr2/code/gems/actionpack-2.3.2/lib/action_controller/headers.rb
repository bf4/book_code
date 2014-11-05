#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'active_support/memoizable'

module ActionController
  module Http
    class Headers < ::Hash
      extend ActiveSupport::Memoizable

      def initialize(*args)
         if args.size == 1 && args[0].is_a?(Hash)
           super()
           update(args[0])
         else
           super
         end
       end

      def [](header_name)
        if include?(header_name)
          super
        else
          super(env_name(header_name))
        end
      end

      private
        # Converts a HTTP header name to an environment variable name.
        def env_name(header_name)
          "HTTP_#{header_name.upcase.gsub(/-/, '_')}"
        end
        memoize :env_name
    end
  end
end
