#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# Legacy TemplateHandler stub
module ActionView
  module TemplateHandlers #:nodoc:
    module Compilable
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def call(template)
          new.compile(template)
        end
      end

      def compile(template)
         raise "Need to implement #{self.class.name}#compile(template)"
       end
    end
  end

  class TemplateHandler
    def self.call(template)
      "#{name}.new(self).render(template, local_assigns)"
    end

    def initialize(view = nil)
      @view = view
    end

    def render(template, local_assigns)
      raise "Need to implement #{self.class.name}#render(template, local_assigns)"
    end
  end
end
