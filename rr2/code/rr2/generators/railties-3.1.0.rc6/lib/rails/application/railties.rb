#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'rails/engine/railties'

module Rails
  class Application < Engine
    class Railties < Rails::Engine::Railties
      def all(&block)
        @all ||= railties + engines + plugins
        @all.each(&block) if block
        @all
      end
    end
  end
end
