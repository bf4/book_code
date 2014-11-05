#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Object
  def to_param
    to_s
  end
end

class TrueClass
  def to_param
    self
  end
end

class FalseClass
  def to_param
    self
  end
end

class NilClass
  def to_param
    self
  end
end

class Regexp #:nodoc:
  def number_of_captures
    Regexp.new("|#{source}").match('').captures.length
  end

  def multiline?
    options & MULTILINE == MULTILINE
  end

  class << self
    def optionalize(pattern)
      case unoptionalize(pattern)
        when /\A(.|\(.*\))\Z/ then "#{pattern}?"
        else "(?:#{pattern})?"
      end
    end

    def unoptionalize(pattern)
      [/\A\(\?:(.*)\)\?\Z/, /\A(.|\(.*\))\?\Z/].each do |regexp|
        return $1 if regexp =~ pattern
      end
      return pattern
    end
  end
end
