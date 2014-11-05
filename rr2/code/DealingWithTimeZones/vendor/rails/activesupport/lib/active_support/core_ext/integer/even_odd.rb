#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module ActiveSupport #:nodoc:
  module CoreExtensions #:nodoc:
    module Integer #:nodoc:
      # For checking if a fixnum is even or odd. 
      # * 1.even? # => false
      # * 1.odd?  # => true
      # * 2.even? # => true
      # * 2.odd? # => false
      module EvenOdd
        def multiple_of?(number)
          self % number == 0
        end
        
        def even?
          multiple_of? 2
        end
        
        def odd?
          !even?
        end
      end
    end
  end
end
