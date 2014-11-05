#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require 'test/unit'

class SanitizationTest < Test::Unit::TestCase
  
  def test_escape_html

require 'cgi'

@escaped = CGI.escapeHTML("<script>alert('hello')</script>")

  end
  
  def test_escape_element

require 'cgi'

@escaped = CGI.escapeElement("<script>alert('hello')</script><br />", ["script"])

  end

  def test_escape_element

require 'cgi'

@escaped = CGI.escapeElement('<script><a href="javascript:alert(\'alert\')">test</a></script>', ["script"])

  end
  
end