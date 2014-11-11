require 'test/unit'
require 'sexp-1'

class SExpressionParserTest < Test::Unit::TestCase
  include SExpressionParser
  
  def test_int
    assert_equal(45, Integer.parse('45'))
  end

  def test_int_fail
    assert_raises(ParserException) { Integer.parse('not an integer') }
  end
end
