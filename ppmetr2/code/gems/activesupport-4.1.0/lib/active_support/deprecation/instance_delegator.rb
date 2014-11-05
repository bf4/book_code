#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'active_support/core_ext/kernel/singleton_class'
require 'active_support/core_ext/module/delegation'

module ActiveSupport
  class Deprecation
    module InstanceDelegator # :nodoc:
      def self.included(base)
        base.extend(ClassMethods)
        base.public_class_method :new
      end

      module ClassMethods # :nodoc:
        def include(included_module)
          included_module.instance_methods.each { |m| method_added(m) }
          super
        end

        def method_added(method_name)
          singleton_class.delegate(method_name, to: :instance)
        end
      end
    end
  end
end
