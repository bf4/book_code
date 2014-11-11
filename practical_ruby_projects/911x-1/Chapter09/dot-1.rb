require 'rubygems'
require 'rparsec'

module Dot
  extend Parsers

  class AST < Struct; end
  AST.new("Integer", :value)
  AST.new("Call", :target, :name)

  Dot = string(".")
  Word = word
  Integer = integer.map{|x| AST::Integer.new(x) }
  Call = sequence(lazy{Expr}, Dot, Word){|expr, dot, name| AST::Call.new(expr, name) }
  Expr = alt(Call, Integer)
  Parser = Expr << eof
end

Dot::Parser.parse("4.inc.recip")