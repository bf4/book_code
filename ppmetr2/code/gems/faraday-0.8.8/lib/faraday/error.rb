#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module Faraday
  module Error
    class ClientError < StandardError
      attr_reader :response

      def initialize(ex, response = nil)
        @wrapped_exception = nil
        @response = response

        if ex.respond_to?(:backtrace)
          super(ex.message)
          @wrapped_exception = ex
        elsif ex.respond_to?(:each_key)
          super("the server responded with status #{ex[:status]}")
          @response = ex
        else
          super(ex.to_s)
        end
      end

      def backtrace
        if @wrapped_exception
          @wrapped_exception.backtrace
        else
          super
        end
      end

      def inspect
        %(#<#{self.class}>)
      end
    end

    class ConnectionFailed < ClientError;   end
    class ResourceNotFound < ClientError;   end
    class ParsingError     < ClientError;   end
    class TimeoutError < ClientError; end
    class MissingDependency < StandardError; end
  end
end
