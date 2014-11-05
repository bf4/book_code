#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'active_record/scoping/default'
require 'active_record/scoping/named'
require 'active_record/base'

module ActiveRecord
  class SchemaMigration < ActiveRecord::Base
    class << self

      def table_name
        "#{table_name_prefix}#{ActiveRecord::Base.schema_migrations_table_name}#{table_name_suffix}"
      end

      def index_name
        "#{table_name_prefix}unique_#{ActiveRecord::Base.schema_migrations_table_name}#{table_name_suffix}"
      end

      def table_exists?
        connection.table_exists?(table_name)
      end

      def create_table(limit=nil)
        unless table_exists?
          version_options = {null: false}
          version_options[:limit] = limit if limit

          connection.create_table(table_name, id: false) do |t|
            t.column :version, :string, version_options
          end
          connection.add_index table_name, :version, unique: true, name: index_name
        end
      end

      def drop_table
        if table_exists?
          connection.remove_index table_name, name: index_name
          connection.drop_table(table_name)
        end
      end
    end

    def version
      super.to_i
    end
  end
end
