#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# The filename begins with "aaa" to ensure this is the first test.
require "cases/helper"

class AAACreateTablesTest < ActiveRecord::TestCase
  self.use_transactional_fixtures = false

  def test_load_schema
    eval(File.read(SCHEMA_ROOT + "/schema.rb"))
    if File.exists?(adapter_specific_schema_file)
      eval(File.read(adapter_specific_schema_file))
    end
    assert true
  end

  def test_drop_and_create_courses_table
    eval(File.read(SCHEMA_ROOT + "/schema2.rb"))
    assert true
  end

  private
  def adapter_specific_schema_file
    SCHEMA_ROOT + '/' + ActiveRecord::Base.connection.adapter_name.downcase + '_specific_schema.rb'
  end
end
