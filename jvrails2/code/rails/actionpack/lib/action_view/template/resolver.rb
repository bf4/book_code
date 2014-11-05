#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
module ActionView
  class Resolver
    cattr_accessor :caching
    self.caching = true

    def initialize
      @cache = Cache.new
    end

    def clear_cache
      @cache.clear
    end

    def find_all(name, prefix=nil, partial=false, details={}, key=nil, locals=[])
      cached(key, [name, prefix, partial], details, locals) do
        find_templates(name, prefix, partial, details)
      end
    end

    private

    def find_templates(name, prefix, partial, details)
      raise NotImplementedError
    end
  end
end
