#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'abstract_unit'
require "#{File.dirname(__FILE__)}/../lib/active_record/schema_dumper"
require 'stringio'

if ActiveRecord::Base.connection.respond_to?(:tables)

  class SchemaDumperTest < Test::Unit::TestCase
    def test_schema_dump
      stream = StringIO.new
      ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, stream)
      output = stream.string

      assert_match %r{create_table "accounts"}, output
      assert_match %r{create_table "authors"}, output
      assert_no_match %r{create_table "schema_info"}, output
    end
    
    def test_schema_dump_includes_not_null_columns
      stream = StringIO.new
      
      ActiveRecord::SchemaDumper.ignore_tables = [/^[^s]/]
      ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, stream)
      output = stream.string
      assert_match %r{:null => false}, output
    end

    def test_schema_dump_with_string_ignored_table
      stream = StringIO.new
      
      ActiveRecord::SchemaDumper.ignore_tables = ['accounts']      
      ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, stream)
      output = stream.string
      assert_no_match %r{create_table "accounts"}, output
      assert_match %r{create_table "authors"}, output
      assert_no_match %r{create_table "schema_info"}, output
    end


    def test_schema_dump_with_regexp_ignored_table
      stream = StringIO.new
      
      ActiveRecord::SchemaDumper.ignore_tables = [/^account/]      
      ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, stream)
      output = stream.string
      assert_no_match %r{create_table "accounts"}, output
      assert_match %r{create_table "authors"}, output
      assert_no_match %r{create_table "schema_info"}, output
    end


    def test_schema_dump_illegal_ignored_table_value
      stream = StringIO.new      
      ActiveRecord::SchemaDumper.ignore_tables = [5]      
      assert_raise(StandardError) do
        ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, stream)
      end
    end
  end

end
