#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveRecord
  class Migration
    module JoinTable #:nodoc:
      private

      def find_join_table_name(table_1, table_2, options = {})
        options.delete(:table_name) || join_table_name(table_1, table_2)
      end

      def join_table_name(table_1, table_2)
        [table_1.to_s, table_2.to_s].sort.join("_").to_sym
      end
    end
  end
end
