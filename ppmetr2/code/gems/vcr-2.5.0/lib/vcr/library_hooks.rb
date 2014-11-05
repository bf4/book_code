#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module VCR
  # @private
  class LibraryHooks
    attr_accessor :exclusive_hook

    def disabled?(hook)
      ![nil, hook].include?(exclusive_hook)
    end

    def exclusively_enabled(hook)
      self.exclusive_hook = hook
      yield
    ensure
      self.exclusive_hook = nil
    end
  end
end

