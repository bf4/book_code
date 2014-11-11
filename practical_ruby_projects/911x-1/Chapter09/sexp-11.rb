require 'rubygems'
require 'rparsec'

module Parsers
  def stringer(opener, closer=nil, translate={})
    closer = opener if closer.nil?
    escape = (string('\\') >> any).map do |charnum|
      escaped = charnum.chr
      translate[escaped] || escaped
    end
    open   = string(opener)
    close  = string(closer)
    other  = not_string(closer).map{|charnum| charnum.chr }
    string = (open >> (escape|other).many << close).map {|strings| strings.to_s }
  end
end

module SExpressionParser
  extend Parsers

  Integer = integer.map{|x| x.to_i }
  Float = number.map{|x| x.to_f }
  Number = longest(Integer, Float)
  Special = Regexp.escape('+-*/=<>?!@#$%^&:~')
  Symbol = regexp(/[\w#{Special}]*[A-Za-z#{Special}][\w#{Special}]*/).map{|s| s.to_sym }
  String = stringer(%q{"}, %q{"}, "n" => "\n", "t" => "\t")
  List = char('(') >> lazy{Values} << char(')')
  Quoted = char("'") >> lazy{Value}.map{|value| [:quote, value] }
  Value = alt(Quoted, List, String, Symbol, Number)
  Values = Value.separated(whitespaces)
  Parser  = Values << eof

  def self.parse(text)
    Parser.parse(text)
  end
end
