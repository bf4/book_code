#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'test/unit'
require File.dirname(__FILE__) + '/../../lib/active_support/core_ext/object'
require File.dirname(__FILE__) + '/../../lib/active_support/core_ext/blank'

class BlankTest < Test::Unit::TestCase
  BLANK = [nil, false, '', '   ', "  \n\t  \r ", [], {}]
  NOT   = [true, 0, 1, 'a', [nil], { nil => 0 }]

  def test_blank
    BLANK.each { |v| assert v.blank?  }
    NOT.each   { |v| assert !v.blank? }
  end
end
