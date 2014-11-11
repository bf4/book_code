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
  Empty = string("").map{|x| nil }
  Call = sequence(Dot, Word, lazy{CallChain}) do |dot, method_name, chain|
    proc do |target|
      call = AST::Call.new(target, method_name)
      return call if chain.nil?
      chain[call]
    end
  end
  CallChain = alt(Call, Empty)
  Expr = sequence(Integer, CallChain) do |expr, chain|
    return expr if chain.nil?
    chain[expr]
  end
  Parser = Expr << eof
end

puts Dot::Parser.parse("4.inc.recip").inspect