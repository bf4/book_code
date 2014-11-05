#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require File.dirname(__FILE__) + '/test_helper'

class ModelTest < Test::Unit::TestCase
  include Globalize

  fixtures :globalize_languages

  def setup
  end

  def test_language
    rfc = RFC_3066.parse 'en-US'
    lang = Language.pick(rfc)
    assert_equal 'en', lang.code
  end

end
