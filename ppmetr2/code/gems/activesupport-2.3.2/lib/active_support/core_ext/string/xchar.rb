#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
begin
  # See http://bogomips.org/fast_xs/ by Eric Wong
  require 'fast_xs'

  class String
    alias_method :original_xs, :to_xs if method_defined?(:to_xs)
    alias_method :to_xs, :fast_xs
  end
rescue LoadError
  # fast_xs extension unavailable.
end
