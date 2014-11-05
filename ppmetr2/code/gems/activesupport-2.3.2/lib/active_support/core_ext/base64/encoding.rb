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
    module Base64 #:nodoc:
      module Encoding
        # Encodes the value as base64 without the newline breaks. This makes the base64 encoding readily usable as URL parameters 
        # or memcache keys without further processing.
        #
        #  ActiveSupport::Base64.encode64s("Original unencoded string") 
        #  # => "T3JpZ2luYWwgdW5lbmNvZGVkIHN0cmluZw=="
        def encode64s(value)
          encode64(value).gsub(/\n/, '')
        end
      end
    end
  end
end
