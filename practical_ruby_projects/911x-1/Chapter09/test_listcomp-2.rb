require 'test/unit'
require 'listcomp-2'

class ListCompTest < Test::Unit::TestCase
  include ListComp::Parsers
  include ListComp
  
  def test_word
    assert_equal(:foo, Word.parse("foo"))
  end

  def test_word_fail
    assert_raises(ParserException) { Word.parse("4foo") }
  end

  def test_symbol
    assert_equal(AST::Symbol.new(:foo), Symbol.parse(':foo'))
  end

  def test_symbol_fail
    assert_raises(ParserException) { Symbol.parse('4') }
  end

  def test_symbol_fail
    assert_raises(ParserException) { Symbol.parse(':4') }
  end

  def test_int
    assert_equal(AST::Integer.new(45), Integer.parse('45'))
  end

  def test_int_fail
    assert_raises(ParserException) { Integer.parse('not an integer') }
  end

  def test_float
    assert_equal(AST::Float.new(4.5), Float.parse('4.5'))
  end

  def test_float_fail
    assert_raises(ParserException) { Float.parse('not a float') }
  end
  
  def test_number
    assert_equal(AST::Float.new(4.5), Number.parse('4.5'))
    assert_equal(AST::Integer.new(45), Number.parse('45'))
  end

  def test_string
    assert_equal(AST::String.new('foo bar'), String2.parse('"foo bar"'))
  end

  def test_string_escape
    assert_equal(AST::String.new('a'), String2.parse('"\\a"'))
  end

  def test_string_escape_quote
    assert_equal(AST::String.new('"'), String2.parse('"\\""'))
  end
end
