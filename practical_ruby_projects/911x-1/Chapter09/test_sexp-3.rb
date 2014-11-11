require 'test/unit'
require 'sexp-3'

class SExpressionParserTest < Test::Unit::TestCase
  include SExpressionParser
  
  def test_int
    assert_equal(45, Integer.parse('45'))
  end

  def test_int_fail
    assert_raises(ParserException) { Integer.parse('not an integer') }
  end

  def test_float
    assert_equal(4.5, Float.parse('4.5'))
  end
  
  def test_float_fail
    assert_raises(ParserException) { Float.parse('not a float') }
  end

  def test_number
    assert_equal(4.5.class, Number.parse('4.5').class)
    assert_equal(45.class, Number.parse('45').class)
  end
end
