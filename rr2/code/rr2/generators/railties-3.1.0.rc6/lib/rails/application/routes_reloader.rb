#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module Rails
  class Application
    class RoutesReloader < ::ActiveSupport::FileUpdateChecker
      attr_reader :route_sets

      def initialize
        super([]) { reload! }
        @route_sets = []
      end

      def reload!
        clear!
        load_paths
        finalize!
      ensure
        revert
      end

    protected

      def clear!
        route_sets.each do |routes|
          routes.disable_clear_and_finalize = true
          routes.clear!
        end
      end

      def load_paths
        paths.each { |path| load(path) }
      end

      def finalize!
        route_sets.each do |routes|
          ActiveSupport.on_load(:action_controller) { routes.finalize! }
        end
      end

      def revert
        route_sets.each do |routes|
          routes.disable_clear_and_finalize = false
        end
      end
    end
  end
end
