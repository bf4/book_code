#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveSupport #:nodoc:
  module CoreExtensions #:nodoc:
    module Numeric #:nodoc:
      # Enables the use of byte calculations and declarations, like 45.bytes + 2.6.megabytes
      module Bytes
        def bytes
          self
        end
        alias :byte :bytes

        def kilobytes
          self * 1024
        end
        alias :kilobyte :kilobytes

        def megabytes
          self * 1024.kilobytes
        end
        alias :megabyte :megabytes

        def gigabytes
          self * 1024.megabytes 
        end
        alias :gigabyte :gigabytes

        def terabytes
          self * 1024.gigabytes
        end
        alias :terabyte :terabytes
        
        def petabytes
          self * 1024.terabytes
        end
        alias :petabyte :petabytes
        
        def exabytes
          self * 1024.petabytes
        end
        alias :exabyte :exabytes
        
      end
    end
  end
end
