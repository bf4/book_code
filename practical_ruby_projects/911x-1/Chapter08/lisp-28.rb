require 'rubygems'
gem 'sexp'
require 'sexp'

class Env
  def initialize(parent=nil, defaults={})
    @parent = parent
    @defs = defaults
  end

  def define(symbol, value)
    @defs[symbol] = value
    return value
  end

  def defined?(symbol)
    return true  if @defs.has_key?(symbol)
    return false if @parent.nil?
    return @parent.defined?(symbol)
  end

  def lookup(symbol)
    return @defs[symbol] if @defs.has_key?(symbol)
    raise "No value for symbol #{symbol}" if @parent.nil?
    return @parent.lookup(symbol)
  end

  def set(symbol, value)
    if @defs.has_key?(symbol)
      @defs[symbol] = value 
    elsif @parent.nil?
      raise "No definition of #{symbol} to set to #{value}"
    else
      @parent.set(symbol, value)
    end
  end
end

class Cons
  attr_reader :car, :cdr
  def initialize(car, cdr)
    @car, @cdr = car, cdr
  end
end

class Object
  def lispeval(env, forms)
    self
  end

  def consify
    self
  end

  def arrayify
    self
  end

  def conslist?
    false
  end
end

class Symbol
  def lispeval(env, forms)
    env.lookup(self)
  end

  def arrayify
    self == :nil ? [] : self
  end

  def conslist?
    self == :nil
  end
end

class Cons
  def lispeval(env, forms)
    return forms.lookup(car).call(env, forms, *cdr.arrayify) if forms.defined?(car)
    func = car.lispeval(env, forms)
    return func.call(*cdr.arrayify.map{|x| x.lispeval(env, forms) })
  end

  def arrayify
    return self unless conslist?
    return [car] + cdr.arrayify
  end

  def conslist?
    cdr.conslist?
  end

  def to_sexp
    return "(cons #{car.to_sexp} #{cdr.to_sexp})" unless conslist?
    return "(#{arrayify.map{|x| x.to_sexp}.join(' ')})"
  end
end

class Lambda
  def initialize(env, forms, params, *code)
    @env    = env
    @forms  = forms
    @params = params.arrayify
    @code   = code
  end

  def call(*args)
    raise "Expected #{@params.size} arguments" unless args.size == @params.size
    newenv = Env.new(@env)
    @params.zip(args).each do |sym, value|
      newenv.define(sym, value)
    end
    @code.map{|c| c.lispeval(newenv, @forms) }.last
  end

  def to_sexp
    "(lambda #{@params.to_sexp} #{@code.map{|x| x.to_sexp}.join(' ')})"
  end
end

class Array
  def consify
    map{|x| x.consify}.reverse.inject(:nil) {|cdr, car| Cons.new(car, cdr)}
  end
end

DEFAULTS = {
  :nil   => :nil,
  :t     => :t,
  :+     => lambda {|x, y| x + y },
  :-     => lambda {|x, y| x - y },
  :*     => lambda {|x, y| x * y },
  :/     => lambda {|x, y| x / y },
  :car   => lambda {|x   | x.car },
  :cdr   => lambda {|x   | x.cdr },
  :cons  => lambda {|x, y| Cons.new(x, y) },
  :atom? => lambda {|x   | x.kind_of?(Cons) ? :nil : :t},
  :eq?   => lambda {|x, y| x.equal?(y) ? :t : :nil},
  :list  => lambda {|*args| Cons.from_a(args)},
  :print => lambda {|*args| puts *args; :nil },
}

FORMS = {
  :quote => lambda {|env, forms, exp| exp },
  :define => lambda {|env, forms, sym, value|
    env.define(sym, value.lispeval(env, forms))
  },
  :set! => lambda {|env, forms, sym, value|
    env.set(sym, value.lispeval(env, forms))
  },
  :if => lambda {|env, forms, cond, xthen, xelse|
    if cond.lispeval(env, forms) != :nil
      xthen.lispeval(env, forms)
    else
      xelse.lispeval(env, forms)
    end
  },
  :lambda => lambda {|env, forms, params, *code|
    Lambda.new(env, forms, params, *code)
  },
  :defmacro => lambda {|env, forms, name, exp|
    func = exp.lispeval(env, forms)
    forms.define(name, lambda{|env2, forms2, *rest| func.call(*rest).lispeval(env, forms) })
    name
  },
}

class Interpreter
  def initialize(defaults=DEFAULTS, forms=FORMS)
    @env   = Env.new(nil, defaults)
    @forms = Env.new(nil, forms)
  end

  def eval(string)
    exps = "(#{string})".parse_sexp
    exps.map do |exp|
      exp.consify.lispeval(@env, @forms)
    end.last
  end

  def repl
    print "> "
    STDIN.each_line do |line|
      begin
        puts self.eval(line).to_sexp
      rescue StandardError => e
        puts "ERROR: #{e}"
      end
      print "> "
    end
  end
end

Interpreter.new.repl