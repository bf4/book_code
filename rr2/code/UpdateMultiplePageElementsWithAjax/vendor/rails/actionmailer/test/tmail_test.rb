#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
$:.unshift(File.dirname(__FILE__) + "/../lib/")
$:.unshift File.dirname(__FILE__) + "/fixtures/helpers"

require 'test/unit'
require 'action_mailer'

class TMailMailTest < Test::Unit::TestCase
  def test_body
    m = TMail::Mail.new
    expected = 'something_with_underscores'
    m.encoding = 'quoted-printable'
    quoted_body = [expected].pack('*M')
    m.body = quoted_body
    assert_equal "something_with_underscores=\n", m.quoted_body
    assert_equal expected, m.body
  end
end
