#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module ActionDispatch
  class ClosedError < StandardError #:nodoc:
    def initialize(kind)
      super "Cannot modify #{kind} because it was closed. This means it was already streamed back to the client or converted to HTTP headers."
    end
  end
end
