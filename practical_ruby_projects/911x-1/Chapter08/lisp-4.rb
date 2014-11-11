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
end

class Cons
  attr_reader :car, :cdr

  def initialize(car, cdr)
    @car, @cdr = car, cdr
  end
end