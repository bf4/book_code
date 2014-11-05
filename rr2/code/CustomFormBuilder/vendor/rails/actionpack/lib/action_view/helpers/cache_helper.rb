#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module ActionView
  module Helpers
    # See ActionController::Caching::Fragments for usage instructions.
    module CacheHelper
      def cache(name = {}, &block)
        @controller.cache_erb_fragment(block, name)
      end
    end
  end
end
