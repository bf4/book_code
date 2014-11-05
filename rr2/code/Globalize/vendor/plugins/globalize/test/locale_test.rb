#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require File.dirname(__FILE__) + '/test_helper'

class LocaleTest < Test::Unit::TestCase
  include Globalize

  fixtures :globalize_languages, :globalize_countries

  def setup
  end

  def test_rfc
    rfc = RFC_3066.parse 'en-US'
    assert_equal 'en', rfc.language
    assert_equal 'US', rfc.country
    assert_equal 'en-US', rfc.locale
  end

  def test_new
    loc = Locale.new('en-US')
    assert_equal 'en', loc.language.code
    assert_equal 'US', loc.country.code
  end

  def test_base
  end

end
