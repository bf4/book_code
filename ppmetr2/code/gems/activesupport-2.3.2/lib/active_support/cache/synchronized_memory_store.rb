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
    # Like MemoryStore, but thread-safe.
    class SynchronizedMemoryStore < MemoryStore
      def initialize
        super
        @guard = Monitor.new
      end

      def fetch(key, options = {})
        @guard.synchronize { super }
      end

      def read(name, options = nil)
        @guard.synchronize { super }
      end

      def write(name, value, options = nil)
        @guard.synchronize { super }
      end

      def delete(name, options = nil)
        @guard.synchronize { super }
      end

      def delete_matched(matcher, options = nil)
        @guard.synchronize { super }
      end

      def exist?(name,options = nil)
        @guard.synchronize { super }
      end

      def increment(key, amount = 1)
        @guard.synchronize { super }
      end

      def decrement(key, amount = 1)
        @guard.synchronize { super }
      end

      def clear
        @guard.synchronize { super }
      end
    end
  end
end
