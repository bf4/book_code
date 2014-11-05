#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Object
  # Can you safely .dup this object?
  # False for nil, false, true, symbols, and numbers; true otherwise.
  def duplicable?
    true
  end
end

class NilClass #:nodoc:
  def duplicable?
    false
  end
end

class FalseClass #:nodoc:
  def duplicable?
    false
  end
end

class TrueClass #:nodoc:
  def duplicable?
    false
  end
end

class Symbol #:nodoc:
  def duplicable?
    false
  end
end

class Numeric #:nodoc:
  def duplicable?
    false
  end
end

class Class #:nodoc:
  def duplicable?
    false
  end
end
