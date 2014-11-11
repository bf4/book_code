require 'rubygems'
require 'rparsec'
require 'extensions/binding'

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

  class AST
    def eval(env)
      value
    end

    class Variable
      def eval(env)
        env[name]
      end
    end

    class Call
      def eval(env)
        target.eval(env).send(method_name, *args.map{|a| a.eval(env) })
      end
    end

    class Comprehension
      def eval(env)
        list = source.eval(env)
        unless conditional.nil?
          list = list.select do |value|
            env[name] = value
            conditional.eval(env)
          end
        end
        list.map do |value|
          env[name] = value
          transform.eval(env)
        end
      end
    end
  end


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
    Comma    = string(",")
    Delim    = _.optional >> Comma << _.optional
    LParen   = string("(")
    RParen   = string(")")
    ArgList  = LParen >> lazy{Expr}.separated(Delim) << RParen
    Call     = sequence(Dot, Word, ArgList){|dot, name, args| [name, args] }
    CallChain = Call.many
    Expr = sequence(Literal, CallChain) do |expr, chain|
      chain.inject(expr){|target, name| AST::Call.new(target, name[0], name[1]) }
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

def list_comp(text, b)
  env = {}
  b.local_variables.each{|var| env[var.to_sym] = b[var] }
  ListComp::Parsers::Comp.parse(text).eval(env)
end