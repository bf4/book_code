#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# encoding: utf-8

module ActiveSupport #:nodoc:
  module Multibyte #:nodoc:
    # Raised when a problem with the encoding was found.
    class EncodingError < StandardError; end
  end
end