#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
# Classes that include this module will automatically be reloaded
# by the Rails dispatcher when Dependencies.mechanism = :load.
module Reloadable
  class << self
    def included(base) #nodoc:
      raise TypeError, "Only Classes can be Reloadable!" unless base.is_a? Class
      
      unless base.respond_to?(:reloadable?)
        class << base
          define_method(:reloadable?) { true }
        end
      end
    end
    
    def reloadable_classes
      included_in_classes.select { |klass| klass.reloadable? }
    end
  end
  
  # Captures the common pattern where a base class should not be reloaded,
  # but its subclasses should be.
  module Subclasses
    def self.included(base) #nodoc:
      base.send :include, Reloadable
      (class << base; self; end).send(:define_method, :reloadable?) do
         base != self
      end
    end
  end
end