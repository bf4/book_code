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
    module Array #:nodoc:
      module Wrapper
        # Wraps the object in an Array unless it's an Array.  Converts the
        # object to an Array using #to_ary if it implements that.
        def wrap(object)
          case object
          when nil
            []
          when self
            object
          else
            if object.respond_to?(:to_ary)
              object.to_ary
            else
              [object]
            end
          end
        end
      end
    end
  end
end
