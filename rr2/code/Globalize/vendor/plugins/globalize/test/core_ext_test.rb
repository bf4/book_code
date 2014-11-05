#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require File.dirname(__FILE__) + '/test_helper'

class CoreExtTest < Test::Unit::TestCase
  include Globalize
  fixtures :globalize_languages, :globalize_countries, :globalize_translations

  def setup
    Locale.clear_cache
    Locale.set("en-US")
  end

  def test_numbers
    assert_equal "23,123,456", 23123456.localize
    assert_equal "23,123,456.45625", 23123456.45625.localize
    Locale.set("de-DE")
    assert_equal "23.123.456", 23123456.localize
    assert_equal "23.123.456,45625", 23123456.45625.localize
    Locale.set("de-CH")
    assert_equal "23'123'456", 23123456.localize
    assert_equal "23'123'456,45625", 23123456.45625.localize
  end

  def test_nil_numbers
    Locale.set(nil)
    assert_equal "23,123,456", 23123456.localize
    assert_equal "23,123,456.45625", 23123456.45625.localize
  end

  def test_indian_scheme
    Locale.set("en-IN")
    assert_equal "2,31,23,456", 23123456.localize
    assert_equal "23,12,34,56,789", 23123456789.localize
    assert_equal "2,31,23,456.45625", 23123456.45625.localize
  end

  def test_times
    t = Time.mktime(2005, 10, 17, 0, 0, 0, 0)
    assert_equal "Mon Oct 17", t.localize("%a %b %d")
    Locale.set("he-IL")
    assert_equal "יום ב', 17 אוק 2005", t.localize("%a, %d %b %Y")
    assert_equal "17.10.2005", t.localize("%c")
  end

  def test_dates
    d = Date.new(2005, 10, 17)
    assert_equal "Mon Oct 17", d.localize("%a %b %d")
    Locale.set("he-IL")
    assert_equal "יום ב', 17 אוק 2005", d.localize("%a, %d %b %Y")
    assert_equal "17.10.2005", d.localize("%c")
  end

  def test_nil_locale
    Locale.set(nil)
    assert_equal "12,345", 12345.localize 
    assert_equal "Not translated", _("Not translated")
  end

  def teardown
    Locale.set("en-US")
  end
end
