#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveSupport
  module Cache
    # A cache store implementation which doesn't actually store anything. Useful in
    # development and test environments where you don't want caching turned on but
    # need to go through the caching interface.
    #
    # This cache does implement the local cache strategy, so values will actually
    # be cached inside blocks that utilize this strategy. See
    # ActiveSupport::Cache::Strategy::LocalCache for more details.
    class NullStore < Store
      def initialize(options = nil)
        super(options)
        extend Strategy::LocalCache
      end

      def clear(options = nil)
      end

      def cleanup(options = nil)
      end

      def increment(name, amount = 1, options = nil)
      end

      def decrement(name, amount = 1, options = nil)
      end

      def delete_matched(matcher, options = nil)
      end

      protected
        def read_entry(key, options) # :nodoc:
        end

        def write_entry(key, entry, options) # :nodoc:
          true
        end

        def delete_entry(key, options) # :nodoc:
          false
        end
    end
  end
end
