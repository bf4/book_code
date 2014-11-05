#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module ActionController
  module Railties
    module Paths
      def self.with(app)
        Module.new do
          define_method(:inherited) do |klass|
            super(klass)

            if namespace = klass.parents.detect {|m| m.respond_to?(:_railtie) }
              paths = namespace._railtie.paths["app/helpers"].existent
            else
              paths = app.config.helpers_paths
            end

            klass.helpers_path = paths
            if klass.superclass == ActionController::Base && ActionController::Base.include_all_helpers
              klass.helper :all
            end
          end
        end
      end
    end
  end
end
