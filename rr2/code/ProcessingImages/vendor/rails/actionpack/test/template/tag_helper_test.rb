#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require File.dirname(__FILE__) + '/../abstract_unit'

require File.dirname(__FILE__) + '/../../lib/action_view/helpers/tag_helper'
require File.dirname(__FILE__) + '/../../lib/action_view/helpers/url_helper'

class TagHelperTest < Test::Unit::TestCase
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::UrlHelper

  def test_tag
    assert_equal "<p class=\"show\" />", tag("p", "class" => "show")
    assert_equal tag("p", "class" => "show"), tag("p", :class => "show")
  end

  def test_tag_options
    assert_equal "<p class=\"elsewhere\" />", tag("p", "class" => "show", :class => "elsewhere")
  end

  def test_tag_options_rejects_nil_option
    assert_equal "<p />", tag("p", :ignored => nil)
  end

  def test_tag_options_accepts_blank_option
    assert_equal "<p included=\"\" />", tag("p", :included => '')
  end

  def test_tag_options_converts_boolean_option
    assert_equal '<p disabled="disabled" multiple="multiple" readonly="readonly" />',
      tag("p", :disabled => true, :multiple => true, :readonly => true)
  end

  def test_content_tag
    assert_equal "<a href=\"create\">Create</a>", content_tag("a", "Create", "href" => "create")
    assert_equal content_tag("a", "Create", "href" => "create"),
                 content_tag("a", "Create", :href => "create")
  end
  
  def test_cdata_section
    assert_equal "<![CDATA[<hello world>]]>", cdata_section("<hello world>")
  end
end
