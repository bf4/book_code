#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'test_helper'

class RecipesHelperTest < ActionView::TestCase
  test "can generate a separator" do
    assert_equal %q{<span class="separator">|</span>}, separator
  end
end
class RecipesHelperTest < ActionView::TestCase
  test "generates a list of links" do
    render :text => tabs("New")
    assert_select "div[id='tabs']"
  end
  test "highlights current tab correctly" do
    render :text => tabs("New")
    assert_select "a[class='current']" do |anchors|
      anchors.each do |anchor|
        assert_equal new_recipe_path, anchor.attributes['href']
      end
    end
  end
end
