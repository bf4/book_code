#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'strscan'

module ActiveSupport #:nodoc:
  module CoreExtensions #:nodoc:
    module String #:nodoc:
      # Custom string iterators
      module Iterators
        def self.append_features(base)
          super unless '1.9'.respond_to?(:each_char)
        end

        # Yields a single-character string for each character in the string.
        # When $KCODE = 'UTF8', multi-byte characters are yielded appropriately.
        def each_char
          scanner, char = StringScanner.new(self), /./mu
          while c = scanner.scan(char)
            yield c
          end
        end
      end
    end
  end
end
