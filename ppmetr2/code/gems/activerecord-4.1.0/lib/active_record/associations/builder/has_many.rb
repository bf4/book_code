#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveRecord::Associations::Builder
  class HasMany < CollectionAssociation #:nodoc:
    def macro
      :has_many
    end

    def valid_options
      super + [:primary_key, :dependent, :as, :through, :source, :source_type, :inverse_of, :counter_cache]
    end

    def self.valid_dependent_options
      [:destroy, :delete_all, :nullify, :restrict_with_error, :restrict_with_exception]
    end
  end
end
