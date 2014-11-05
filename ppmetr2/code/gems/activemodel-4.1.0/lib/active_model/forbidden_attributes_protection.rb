#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveModel
  # Raised when forbidden attributes are used for mass assignment.
  #
  #   class Person < ActiveRecord::Base
  #   end
  #
  #   params = ActionController::Parameters.new(name: 'Bob')
  #   Person.new(params)
  #   # => ActiveModel::ForbiddenAttributesError
  #
  #   params.permit!
  #   Person.new(params)
  #   # => #<Person id: nil, name: "Bob">
  class ForbiddenAttributesError < StandardError
  end

  module ForbiddenAttributesProtection # :nodoc:
    protected
      def sanitize_for_mass_assignment(attributes)
        if attributes.respond_to?(:permitted?) && !attributes.permitted?
          raise ActiveModel::ForbiddenAttributesError
        else
          attributes
        end
      end
  end
end
