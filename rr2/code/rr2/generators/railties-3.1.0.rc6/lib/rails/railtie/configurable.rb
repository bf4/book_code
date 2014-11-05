#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'active_support/concern'

module Rails
  class Railtie
    module Configurable
      extend ActiveSupport::Concern

      module ClassMethods
        delegate :config, :to => :instance

        def inherited(base)
          raise "You cannot inherit from a #{self.superclass.name} child"
        end

        def instance
          @instance ||= new
        end

        def respond_to?(*args)
          super || instance.respond_to?(*args)
        end

        def configure(&block)
          class_eval(&block)
        end

        protected

        def method_missing(*args, &block)
          instance.send(*args, &block)
        end
      end
    end
  end
end
