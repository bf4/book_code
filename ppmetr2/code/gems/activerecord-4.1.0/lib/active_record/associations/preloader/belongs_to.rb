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
      class BelongsTo < SingularAssociation #:nodoc:

        def association_key_name
          reflection.options[:primary_key] || klass && klass.primary_key
        end

        def owner_key_name
          reflection.foreign_key
        end

      end
    end
  end
end
