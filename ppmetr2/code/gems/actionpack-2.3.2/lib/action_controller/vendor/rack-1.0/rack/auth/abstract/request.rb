#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module Rack
  module Auth
    class AbstractRequest

      def initialize(env)
        @env = env
      end

      def provided?
        !authorization_key.nil?
      end

      def parts
        @parts ||= @env[authorization_key].split(' ', 2)
      end

      def scheme
        @scheme ||= parts.first.downcase.to_sym
      end

      def params
        @params ||= parts.last
      end


      private

      AUTHORIZATION_KEYS = ['HTTP_AUTHORIZATION', 'X-HTTP_AUTHORIZATION', 'X_HTTP_AUTHORIZATION']

      def authorization_key
        @authorization_key ||= AUTHORIZATION_KEYS.detect { |key| @env.has_key?(key) }
      end

    end

  end
end
