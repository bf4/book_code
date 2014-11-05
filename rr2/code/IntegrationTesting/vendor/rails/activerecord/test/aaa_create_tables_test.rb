#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
# The filename begins with "aaa" to ensure this is the first test.
require 'abstract_unit'

class AAACreateTablesTest < Test::Unit::TestCase
  self.use_transactional_fixtures = false

  def setup
    @base_path = "#{File.dirname(__FILE__)}/fixtures/db_definitions"
  end

  def test_drop_and_create_main_tables
    recreate ActiveRecord::Base
    assert true
  end

  def test_load_schema
    eval(File.read("#{File.dirname(__FILE__)}/fixtures/db_definitions/schema.rb"))
    assert true
  end
  
  def test_drop_and_create_courses_table
    recreate Course, '2'
    assert true
  end

  private
    def recreate(base, suffix = nil)
      connection = base.connection
      adapter_name = connection.adapter_name.downcase + suffix.to_s
      execute_sql_file "#{@base_path}/#{adapter_name}.drop.sql", connection
      execute_sql_file "#{@base_path}/#{adapter_name}.sql", connection
    end

    def execute_sql_file(path, connection)
      # OpenBase has a different format for sql files
      if current_adapter?(:OpenBaseAdapter) then
          File.read(path).split("go").each_with_index do |sql, i|
            begin
              # OpenBase does not support comments embedded in sql
              connection.execute(sql,"SQL statement ##{i}") unless sql.blank?
            rescue ActiveRecord::StatementInvalid
              #$stderr.puts "warning: #{$!}"
            end
          end
      else
        File.read(path).split(';').each_with_index do |sql, i|
          begin
            connection.execute("\n\n-- statement ##{i}\n#{sql}\n") unless sql.blank?
          rescue ActiveRecord::StatementInvalid
            #$stderr.puts "warning: #{$!}"
          end
        end
      end
    end
end
