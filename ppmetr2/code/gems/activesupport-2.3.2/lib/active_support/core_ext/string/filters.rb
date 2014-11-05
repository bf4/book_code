#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveSupport
  module CoreExtensions
    module String
      module Filters
        def squish # ...
          dup.squish!
        end

        # Performs a destructive squish. See String#squish.
        def squish! # ...
          strip!
          gsub!(/\s+/, ' ')
          self
        end
      end
    end
  end
end
