#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'test/unit'

# mock to enable testing without activerecord
module ActiveRecord
  class Base
    def save!
    end
  end
end

require File.dirname(__FILE__) + '/../lib/active_support/inflector'
require File.dirname(__FILE__) + '/../lib/active_support/whiny_nil'

class WhinyNilTest < Test::Unit::TestCase
  def test_unchanged
    nil.method_thats_not_in_whiners
  rescue NoMethodError => nme
    assert_match(/nil.method_thats_not_in_whiners/, nme.message)
  end
  
  def test_active_record
    nil.save!
  rescue NoMethodError => nme
    assert(!(nme.message =~ /nil:NilClass/))
    assert_match(/nil\.save!/, nme.message)
  end
  
  def test_array
    nil.each
  rescue NoMethodError => nme
    assert(!(nme.message =~ /nil:NilClass/))
    assert_match(/nil\.each/, nme.message)
  end

  def test_id
    nil.id
  rescue RuntimeError => nme
    assert(!(nme.message =~ /nil:NilClass/))
  end
end
