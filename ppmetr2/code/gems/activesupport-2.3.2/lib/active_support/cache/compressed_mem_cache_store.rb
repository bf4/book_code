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
    class CompressedMemCacheStore < MemCacheStore
      def read(name, options = nil)
        if value = super(name, (options || {}).merge(:raw => true))
          if raw?(options)
            value
          else
            Marshal.load(ActiveSupport::Gzip.decompress(value))
          end
        end
      end

      def write(name, value, options = nil)
        value = ActiveSupport::Gzip.compress(Marshal.dump(value)) unless raw?(options)
        super(name, value, (options || {}).merge(:raw => true))
      end
    end
  end
end
