#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'action_dispatch/http/mime_type'
require 'active_support/core_ext/class/attribute'

# Legacy TemplateHandler stub
module ActionView
  class Template
    module Handlers #:nodoc:
      module Compilable
        def self.included(base)
          ActiveSupport::Deprecation.warn "Including Compilable in your template handler is deprecated. " <<
            "Since Rails 3, all the API your template handler needs to implement is to respond to #call."
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

    class Template::Handler
      class_attribute :default_format
      self.default_format = Mime::HTML

      def self.inherited(base)
        ActiveSupport::Deprecation.warn "Inheriting from ActionView::Template::Handler is deprecated. " <<
          "Since Rails 3, all the API your template handler needs to implement is to respond to #call."
        super
      end

      def self.call(template)
        raise "Need to implement #{self.class.name}#call(template)"
      end

      def render(template, local_assigns)
        raise "Need to implement #{self.class.name}#render(template, local_assigns)"
      end
    end
  end

  TemplateHandlers = Template::Handlers
  TemplateHandler = Template::Handler
end
