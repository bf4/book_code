#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'abstract_unit'

class CDATANodeTest < Test::Unit::TestCase
  def setup
    @node = HTML::CDATA.new(nil, 0, 0, "<p>howdy</p>")
  end

  def test_to_s
    assert_equal "<![CDATA[<p>howdy</p>]]>", @node.to_s
  end

  def test_content
    assert_equal "<p>howdy</p>", @node.content
  end
end
