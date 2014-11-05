#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'set'

module ActiveSupport #:nodoc:
  module CoreExtensions #:nodoc:
    module Hash #:nodoc:
      # Return a hash that includes everything but the given keys. This is useful for
      # limiting a set of parameters to everything but a few known toggles:
      #
      #   @person.update_attributes(params[:person].except(:admin))
      module Except
        # Returns a new hash without the given keys.
        def except(*keys)
          dup.except!(*keys)
        end

        # Replaces the hash without the given keys.
        def except!(*keys)
          keys.map! { |key| convert_key(key) } if respond_to?(:convert_key)
          keys.each { |key| delete(key) }
          self
        end
      end
    end
  end
end
