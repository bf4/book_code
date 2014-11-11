require 'rubygems'
require 'rparsec'

module SExpressionParser
  extend Parsers

  Integer = integer.map{|x| x.to_i }
  Float = number.map{|x| x.to_f }
  Number = longest(Integer, Float)
  Special = Regexp.escape('+-*/=<>?!@#$%^&:~')
  Symbol = regexp(/[\w#{Special}]*[A-Za-z#{Special}][\w#{Special}]*/).map{|s| s.to_sym }
  List = char('(') >> lazy{Values} << char(')')
  Quoted = char("'") >> lazy{Value}.map{|value| [:quote, value] }
  Value = alt(Quoted, List, Symbol, Number)
  Values = Value.separated(whitespaces)
  Parser  = Values << eof

  def self.parse(text)
    Parser.parse(text)
  end
end
