#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'active_record/connection_adapters/sqlite_adapter'

module ActiveRecord
  class Base
    # sqlite3 adapter reuses sqlite_connection.
    def self.sqlite3_connection(config) # :nodoc:
      parse_sqlite_config!(config)

      unless self.class.const_defined?(:SQLite3)
        require_library_or_gem(config[:adapter])
      end

      db = SQLite3::Database.new(
        config[:database],
        :results_as_hash => true,
        :type_translation => false
      )

      db.busy_timeout(config[:timeout]) unless config[:timeout].nil?

      ConnectionAdapters::SQLite3Adapter.new(db, logger, config)
    end
  end

  module ConnectionAdapters #:nodoc:
    class SQLite3Adapter < SQLiteAdapter # :nodoc:
      def table_structure(table_name)
        returning structure = @connection.table_info(quote_table_name(table_name)) do
          raise(ActiveRecord::StatementInvalid, "Could not find table '#{table_name}'") if structure.empty?
        end
      end
    end
  end
end
