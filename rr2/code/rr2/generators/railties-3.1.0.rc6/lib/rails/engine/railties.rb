#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module Rails
  class Engine < Railtie
    class Railties
      # TODO Write tests for this behavior extracted from Application
      def initialize(config)
        @config = config
      end

      def all(&block)
        @all ||= plugins
        @all.each(&block) if block
        @all
      end

      def plugins
        @plugins ||= begin
          plugin_names = (@config.plugins || [:all]).map { |p| p.to_sym }
          Plugin.all(plugin_names, @config.paths["vendor/plugins"].existent)
        end
      end

      def self.railties
        @railties ||= ::Rails::Railtie.subclasses.map(&:instance)
      end

      def self.engines
        @engines ||= ::Rails::Engine.subclasses.map(&:instance)
      end

      delegate :railties, :engines, :to => "self.class"
    end
  end
end
