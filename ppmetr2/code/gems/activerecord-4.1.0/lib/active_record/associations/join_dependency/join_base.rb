#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'active_record/associations/join_dependency/join_part'

module ActiveRecord
  module Associations
    class JoinDependency # :nodoc:
      class JoinBase < JoinPart # :nodoc:
        def match?(other)
          return true if self == other
          super && base_klass == other.base_klass
        end

        def table
          base_klass.arel_table
        end

        def aliased_table_name
          base_klass.table_name
        end
      end
    end
  end
end
