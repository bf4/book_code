#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'abstract_unit'

class HeaderTest < Test::Unit::TestCase
  def setup
    @headers = ActionController::Http::Headers.new("HTTP_CONTENT_TYPE"=>"text/plain")
  end
  
  def test_content_type_works
    assert_equal "text/plain", @headers["Content-Type"]
    assert_equal "text/plain", @headers["content-type"]
    assert_equal "text/plain", @headers["CONTENT_TYPE"]
    assert_equal "text/plain", @headers["HTTP_CONTENT_TYPE"]    
  end
end
