#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'
class RecipeLinkHelperTest < Test::Unit::TestCase
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::TagHelper
  include ApplicationHelper
  def setup
    @controller = RecipesController.new
    request    = ActionController::TestRequest.new
    @controller.instance_eval { @params = {}, @request = request }
    @controller.send(:initialize_current_url)    
  end
  def test_link_to_recipe_with_comments_shows_count
    r = Recipe.create(:name => "test")
    3.times {r.comments.create}
    assert_match(/\(3\)/, recipe_link(r))
  end
end
