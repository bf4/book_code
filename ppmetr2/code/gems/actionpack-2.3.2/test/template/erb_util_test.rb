#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'abstract_unit'

class ErbUtilTest < Test::Unit::TestCase
  include ERB::Util

  ERB::Util::HTML_ESCAPE.each do |given, expected|
    define_method "test_html_escape_#{expected.gsub /\W/, ''}" do
      assert_equal expected, html_escape(given)
    end

    unless given == '"'
      define_method "test_json_escape_#{expected.gsub /\W/, ''}" do
        assert_equal ERB::Util::JSON_ESCAPE[given], json_escape(given)
      end
    end
  end
  
  def test_rest_in_ascii
    (0..127).to_a.map(&:chr).each do |chr|
      next if %w(& " < >).include?(chr)
      assert_equal chr, html_escape(chr)
    end
  end
end
