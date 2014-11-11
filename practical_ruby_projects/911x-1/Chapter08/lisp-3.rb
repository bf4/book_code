class Env
  def initialize(parent=nil, defaults={})
    @parent = parent
    @defs = defaults
  end

  def define(symbol, value)
    @defs[symbol] = value
    return value
  end
end

class Cons
  attr_reader :car, :cdr

  def initialize(car, cdr)
    @car, @cdr = car, cdr
  end
end