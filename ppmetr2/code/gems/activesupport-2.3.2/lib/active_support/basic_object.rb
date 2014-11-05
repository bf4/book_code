#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# A base class with no predefined methods that tries to behave like Builder's
# BlankSlate in Ruby 1.9. In Ruby pre-1.9, this is actually the
# Builder::BlankSlate class.
#
# Ruby 1.9 introduces BasicObject which differs slightly from Builder's
# BlankSlate that has been used so far. ActiveSupport::BasicObject provides a
# barebones base class that emulates Builder::BlankSlate while still relying on
# Ruby 1.9's BasicObject in Ruby 1.9.
module ActiveSupport
  if defined? ::BasicObject
    class BasicObject < ::BasicObject
      undef_method :==
      undef_method :equal?

      # Let ActiveSupport::BasicObject at least raise exceptions.
      def raise(*args)
        ::Object.send(:raise, *args)
      end
    end
  else
    require 'blankslate'
    BasicObject = BlankSlate
  end
end
