#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'active_support/inflector'

module ActiveSupport #:nodoc:
  module CoreExtensions #:nodoc:
    module Integer #:nodoc:
      module Inflections
        # Ordinalize turns a number into an ordinal string used to denote the
        # position in an ordered sequence such as 1st, 2nd, 3rd, 4th.
        #
        #   1.ordinalize    # => "1st"
        #   2.ordinalize    # => "2nd"
        #   1002.ordinalize # => "1002nd"
        #   1003.ordinalize # => "1003rd"
        def ordinalize
          Inflector.ordinalize(self)
        end
      end
    end
  end
end
