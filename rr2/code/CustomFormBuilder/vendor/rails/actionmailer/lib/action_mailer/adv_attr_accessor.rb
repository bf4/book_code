#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module ActionMailer
  module AdvAttrAccessor #:nodoc:
    def self.append_features(base)
      super
      base.extend(ClassMethods)
    end

    module ClassMethods #:nodoc:
      def adv_attr_accessor(*names)
        names.each do |name|
          ivar = "@#{name}"

          define_method("#{name}=") do |value|
            instance_variable_set(ivar, value)
          end

          define_method(name) do |*parameters|
            raise ArgumentError, "expected 0 or 1 parameters" unless parameters.length <= 1
            if parameters.empty?
              if instance_variables.include?(ivar)
                instance_variable_get(ivar)
              end
            else
              instance_variable_set(ivar, parameters.first)
            end
          end
        end
      end
    end
  end
end
