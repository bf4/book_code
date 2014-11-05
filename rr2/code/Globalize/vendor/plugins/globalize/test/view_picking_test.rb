#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require File.dirname(__FILE__) + '/test_helper'

class ViewPickingTest < Test::Unit::TestCase
  include Globalize
  fixtures :globalize_languages, :globalize_countries

  class TestController < ActionView::Base
  end

  def setup
    Locale.set("en-US")
    @base_path = File.dirname(__FILE__) + '/views'
  end

  def test_first
    tc = TestController.new
    tc.base_path = @base_path
    assert_match /English/, tc.render("test")
    assert_no_match /Hebrew/, tc.render("test")
    Locale.set("he-IL")
    assert_match /Hebrew/, tc.render("test")
    assert_no_match /English/, tc.render("test")
  end

  def test_non_full_path
    tc = TestController.new
    tc.base_path = @base_path
    assert_match /English/, tc.render_file("#{@base_path}/test.rhtml", false)
  end

  def test_nil
    Locale.set(nil)
    tc = TestController.new
    tc.base_path = @base_path
    assert_match /English/, tc.render("test")
    assert_no_match /Hebrew/, tc.render("test")
    Locale.set("he-IL")
    assert_match /Hebrew/, tc.render("test")
    assert_no_match /English/, tc.render("test")
  end

  def test_non_full_path_nil
    Locale.set(nil)
    tc = TestController.new
    tc.base_path = @base_path
    assert_match /English/, tc.render_file("#{@base_path}/test.rhtml", false)
  end

end
