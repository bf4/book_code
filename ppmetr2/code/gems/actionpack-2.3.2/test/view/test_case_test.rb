#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'abstract_unit'

class TestCaseTest < ActionView::TestCase
  def test_should_have_current_url
    controller = TestController.new
    assert_nothing_raised(NoMethodError){ controller.url_for({:controller => "foo", :action => "index"}) }
  end
end
