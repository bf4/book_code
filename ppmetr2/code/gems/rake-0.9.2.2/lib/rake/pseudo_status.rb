#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module Rake

  ####################################################################
  # Exit status class for times the system just gives us a nil.
  class PseudoStatus
    attr_reader :exitstatus
    def initialize(code=0)
      @exitstatus = code
    end
    def to_i
      @exitstatus << 8
    end
    def >>(n)
      to_i >> n
    end
    def stopped?
      false
    end
    def exited?
      true
    end
  end

end
