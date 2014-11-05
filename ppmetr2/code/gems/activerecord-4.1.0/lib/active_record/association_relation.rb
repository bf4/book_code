#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveRecord
  class AssociationRelation < Relation
    def initialize(klass, table, association)
      super(klass, table)
      @association = association
    end

    def proxy_association
      @association
    end

    private

    def exec_queries
      super.each { |r| @association.set_inverse_instance r }
    end
  end
end
