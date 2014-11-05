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
      class HasManyThrough < CollectionAssociation #:nodoc:
        include ThroughAssociation

        def associated_records_by_owner(preloader)
          records_by_owner = super

          if reflection_scope.distinct_value
            records_by_owner.each_value { |records| records.uniq! }
          end

          records_by_owner
        end
      end
    end
  end
end
