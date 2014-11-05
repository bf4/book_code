#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'abstract_unit'
require 'fixtures/default'

class DefaultsTest < Test::Unit::TestCase
  if %w(PostgreSQL).include? ActiveRecord::Base.connection.adapter_name
    def test_default_integers
      default = Default.new
      assert_instance_of(Fixnum, default.positive_integer)
      assert_equal(default.positive_integer, 1)
      assert_instance_of(Fixnum, default.negative_integer)
      assert_equal(default.negative_integer, -1)
    end
  else
    def test_dummy
      assert true
    end
  end
end
