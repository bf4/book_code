require 'test/unit'
require 'sexp-11'

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

  def test_symbol_simple
    assert_equal(:foo, Symbol.parse('foo'))
  end

  def test_symbol_tricky
    assert_equal(:+, Symbol.parse('+'))
  end
 
  def test_number_letter_number
    assert_equal(:'4w4', Symbol.parse('4w4'))
  end

  def test_symbol_not_all_numbers
    assert_raises(ParserException) { Symbol.parse('47') }
  end

  def test_value
    assert_equal(:x, Value.parse('x'))
    assert_equal(7, Value.parse('7'))
  end

  def test_value_on_numbers
    assert_equal(:'4w4', Value.parse('4w4'))
  end

  def test_values
    assert_equal([:x, 1], Values.parse('x 1'))
  end

  def test_list_empty
    assert_equal([], List.parse('()'))
  end

  def test_list_of_symbols
    assert_equal([:x, :y, :z], List.parse('(x y z)'))
  end

  def test_list_of_lists
    assert_equal([[:x], [:y, :z]], List.parse('((x) (y z))'))
  end

  def test_quoted
    assert_equal([:quote, :foo], Quoted.parse("'foo"))
  end

  def test_quoted_double
    assert_equal([:quote, [:quote, :foo]], Quoted.parse("''foo"))
  end

  def test_quoted_complicated
    assert_equal([:quote, [:foo, [:quote, :baz]]], Quoted.parse("'(foo 'baz)"))
  end

  def test_string
    assert_equal('foo bar', String.parse(%q{"foo bar"}))
  end

  def test_string_escape
    assert_equal('a', String.parse(%q{"\a"}))
  end

  def test_string_escape_quote
    assert_equal(%q{"}, String.parse(%q{"\""}))
  end

  def test_system
    assert_equal([[:*], [:quote, [:a3e, :b, :c]], :b, "a\nstring", [:add, 4, 5.5]], Parser.parse("(*) '(a3e b c) b \"a\\nstring\" (add 4 5.5)"))
  end
end
