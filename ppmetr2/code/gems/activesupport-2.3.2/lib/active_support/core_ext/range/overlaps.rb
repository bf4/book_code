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
    module Range #:nodoc:
      # Check if Ranges overlap.
      module Overlaps
        # Compare two ranges and see if they overlap eachother
        #  (1..5).overlaps?(4..6) # => true
        #  (1..5).overlaps?(7..9) # => false
        def overlaps?(other)
          include?(other.first) || other.include?(first)
        end
      end
    end
  end
end
