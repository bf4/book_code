#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module AbstractController
  module Railties
    module RoutesHelpers
      def self.with(routes)
        Module.new do
          define_method(:inherited) do |klass|
            super(klass)
            if namespace = klass.parents.detect {|m| m.respond_to?(:_railtie) }
              klass.send(:include, namespace._railtie.routes.url_helpers)
            else
              klass.send(:include, routes.url_helpers)
            end
          end
        end
      end
    end
  end
end
