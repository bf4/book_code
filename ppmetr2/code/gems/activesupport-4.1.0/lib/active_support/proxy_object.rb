#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveSupport
  # A class with no predefined methods that behaves similarly to Builder's
  # BlankSlate. Used for proxy classes.
  class ProxyObject < ::BasicObject
    undef_method :==
    undef_method :equal?

    # Let ActiveSupport::ProxyObject at least raise exceptions.
    def raise(*args)
      ::Object.send(:raise, *args)
    end
  end
end
