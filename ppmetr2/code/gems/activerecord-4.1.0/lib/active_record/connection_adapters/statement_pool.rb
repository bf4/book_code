#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveRecord
  module ConnectionAdapters
    class StatementPool
      include Enumerable

      def initialize(connection, max = 1000)
        @connection = connection
        @max        = max
      end

      def each
        raise NotImplementedError
      end

      def key?(key)
        raise NotImplementedError
      end

      def [](key)
        raise NotImplementedError
      end

      def length
        raise NotImplementedError
      end

      def []=(sql, key)
        raise NotImplementedError
      end

      def clear
        raise NotImplementedError
      end

      def delete(key)
        raise NotImplementedError
      end
    end
  end
end
