#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveRecord
  module Associations
    class Preloader
      class SingularAssociation < Association #:nodoc:

        private

        def preload(preloader)
          associated_records_by_owner(preloader).each do |owner, associated_records|
            record = associated_records.first

            association = owner.association(reflection.name)
            association.target = record
            association.set_inverse_instance(record) if record
          end
        end

      end
    end
  end
end
