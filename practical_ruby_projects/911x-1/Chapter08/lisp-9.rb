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
end

class Symbol
  def lispeval(env, forms)
    env.lookup(self)
  end
end