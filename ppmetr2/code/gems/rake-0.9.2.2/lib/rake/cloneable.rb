#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module Rake
  # ##########################################################################
  # Mixin for creating easily cloned objects.
  #
  module Cloneable
    # Clone an object by making a new object and setting all the instance
    # variables to the same values.
    def dup
      sibling = self.class.new
      instance_variables.each do |ivar|
        value = self.instance_variable_get(ivar)
        new_value = value.clone rescue value
        sibling.instance_variable_set(ivar, new_value)
      end
      sibling.taint if tainted?
      sibling
    end

    def clone
      sibling = dup
      sibling.freeze if frozen?
      sibling
    end
  end
end
