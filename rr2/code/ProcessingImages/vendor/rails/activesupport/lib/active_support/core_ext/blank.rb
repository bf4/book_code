#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class Object #:nodoc:
  # "", "   ", nil, [], and {} are blank
  def blank?
    if respond_to?(:empty?) && respond_to?(:strip)
      empty? or strip.empty?
    elsif respond_to?(:empty?)
      empty?
    else
      !self
    end
  end
end

class NilClass #:nodoc:
  def blank?
    true
  end
end

class FalseClass #:nodoc:
  def blank?
    true
  end
end

class TrueClass #:nodoc:
  def blank?
    false
  end
end

class Array #:nodoc:
  alias_method :blank?, :empty?
end

class Hash #:nodoc:
  alias_method :blank?, :empty?
end

class String #:nodoc:
  def blank?
    empty? || strip.empty?
  end
end

class Numeric #:nodoc:
  def blank?
    false
  end
end