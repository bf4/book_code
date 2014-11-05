#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'cases/helper'

class PostgresqlActiveSchemaTest < Test::Unit::TestCase
  def setup
    ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.class_eval do
      alias_method :real_execute, :execute
      def execute(sql, name = nil) sql end
    end
  end

  def teardown
    ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.send(:alias_method, :execute, :real_execute)
  end

  def test_create_database_with_encoding
    assert_equal %(CREATE DATABASE "matt" ENCODING = 'utf8'), create_database(:matt)
    assert_equal %(CREATE DATABASE "aimonetti" ENCODING = 'latin1'), create_database(:aimonetti, :encoding => :latin1)
  end

  private
    def method_missing(method_symbol, *arguments)
      ActiveRecord::Base.connection.send(method_symbol, *arguments)
    end
end
