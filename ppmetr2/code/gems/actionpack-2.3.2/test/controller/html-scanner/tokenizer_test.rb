#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'abstract_unit'

class TokenizerTest < Test::Unit::TestCase

  def test_blank
    tokenize ""
    assert_end
  end

  def test_space
    tokenize " "
    assert_next " "
    assert_end
  end

  def test_tag_simple_open
    tokenize "<tag>"
    assert_next "<tag>"
    assert_end
  end

  def test_tag_simple_self_closing
    tokenize "<tag />"
    assert_next "<tag />"
    assert_end
  end

  def test_tag_simple_closing
    tokenize "</tag>"
    assert_next "</tag>"
  end
  
  def test_tag_with_single_quoted_attribute
    tokenize %{<tag a='hello'>x}
    assert_next %{<tag a='hello'>}
  end

  def test_tag_with_single_quoted_attribute_with_escape
    tokenize %{<tag a='hello\\''>x}
    assert_next %{<tag a='hello\\''>}
  end

  def test_tag_with_double_quoted_attribute
    tokenize %{<tag a="hello">x}
    assert_next %{<tag a="hello">}
  end

  def test_tag_with_double_quoted_attribute_with_escape
    tokenize %{<tag a="hello\\"">x}
    assert_next %{<tag a="hello\\"">}
  end
  
  def test_tag_with_unquoted_attribute
    tokenize %{<tag a=hello>x}
    assert_next %{<tag a=hello>}
  end

  def test_tag_with_lt_char_in_attribute
    tokenize %{<tag a="x < y">x}
    assert_next %{<tag a="x < y">}
  end
  
  def test_tag_with_gt_char_in_attribute
    tokenize %{<tag a="x > y">x}
    assert_next %{<tag a="x > y">}
  end
  
  def test_doctype_tag
    tokenize %{<!DOCTYPE "blah" "blah" "blah">\n    <html>}
    assert_next %{<!DOCTYPE "blah" "blah" "blah">}
    assert_next %{\n    }
    assert_next %{<html>}
  end

  def test_cdata_tag
    tokenize %{<![CDATA[<br>]]>}
    assert_next %{<![CDATA[<br>]]>}
    assert_end
  end

  def test_unterminated_cdata_tag
    tokenize %{<content:encoded><![CDATA[ neverending...}
    assert_next %{<content:encoded>}
    assert_next %{<![CDATA[ neverending...}
    assert_end
  end

  def test_less_than_with_space
    tokenize %{original < hello > world}
    assert_next %{original }
    assert_next %{< hello > world}
  end
  
  def test_less_than_without_matching_greater_than
    tokenize %{hello <span onmouseover="gotcha"\n<b>foo</b>\nbar</span>}
    assert_next %{hello }
    assert_next %{<span onmouseover="gotcha"\n}
    assert_next %{<b>}
    assert_next %{foo}
    assert_next %{</b>}
    assert_next %{\nbar}
    assert_next %{</span>}
    assert_end
  end

  def test_unterminated_comment
    tokenize %{hello <!-- neverending...}
    assert_next %{hello }
    assert_next %{<!-- neverending...}
    assert_end
  end
  
  private
  
    def tokenize(text)
      @tokenizer = HTML::Tokenizer.new(text)
    end
    
    def assert_next(expected, message=nil)
      token = @tokenizer.next
      assert_equal expected, token, message
    end
    
    def assert_sequence(*expected)
      assert_next expected.shift until expected.empty?
    end
    
    def assert_end(message=nil)
      assert_nil @tokenizer.next, message
    end
end
