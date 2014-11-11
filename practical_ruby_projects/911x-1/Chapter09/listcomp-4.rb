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

module ListComp
  class AST < Struct; end
  AST.new("Symbol", :value)
  AST.new("Integer", :value)
  AST.new("Float", :value)
  AST.new("String", :value)
  AST.new("Variable", :name)
  AST.new("Call", :target, :method_name, :args)
  AST.new("Comprehension", :transform, :name, :source, :conditional)

  ParsersAlias = Parsers
  module Parsers
    extend ParsersAlias

    _ = whitespaces
    Special  = Regexp.escape('+-*/_=<>?!@#$%^&:~')
    Word    = regexp(/[A-Za-z#{Special}][\w#{Special}]*/).map{|s| s.to_sym }
    Symbol  = string(":") >> Word.map{|x| AST::Symbol.new(x) }
    Integer = integer.map{|x| AST::Integer.new(x.to_i) }
    Float   = number.map{|x| AST::Float.new(x.to_f) }
    Number  = longest(Integer, Float)
    String1 = stringer("'").map{|x| AST::String.new(x) }
    String2 = stringer('"', '"', "n" => "\n", "t" => "\t").map{|x| AST::String.new(x) }
    Variable = Word.map{|x| AST::Variable.new(x) }
    Literal  = alt(Symbol, Number, String1, String2, Variable)
    Dot      = string(".")
    CallChain = sequence(Dot, Word).many
    Expr = sequence(Literal, CallChain) do |expr, chain|
      chain.inject(expr){|target, name| AST::Call.new(target, name) }
    end

    For  = string("for")
    In   = string("in")
    If   = string("if")
    
    Conditional = If >> _ >> Expr
    Iteration = sequence(Expr, _, For, _, Word, _, In, _, Expr) do
      |transform, w1, f, w2, name, w3, i, w4, source|
      AST::Comprehension.new(transform, name, source)
    end
    CompBody = sequence(Iteration, (_ >> Conditional).optional) do |comp, cond|
      comp.conditional = cond
      comp
    end
    Comp = char("[") >> CompBody << char("]") << eof
  end
end
