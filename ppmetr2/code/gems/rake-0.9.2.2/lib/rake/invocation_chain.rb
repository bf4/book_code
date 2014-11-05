#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module Rake

  ####################################################################
  # InvocationChain tracks the chain of task invocations to detect
  # circular dependencies.
  class InvocationChain
    def initialize(value, tail)
      @value = value
      @tail = tail
    end

    def member?(obj)
      @value == obj || @tail.member?(obj)
    end

    def append(value)
      if member?(value)
        fail RuntimeError, "Circular dependency detected: #{to_s} => #{value}"
      end
      self.class.new(value, self)
    end

    def to_s
      "#{prefix}#{@value}"
    end

    def self.append(value, chain)
      chain.append(value)
    end

    private

    def prefix
      "#{@tail.to_s} => "
    end

    class EmptyInvocationChain
      def member?(obj)
        false
      end
      def append(value)
        InvocationChain.new(value, self)
      end
      def to_s
        "TOP"
      end
    end

    EMPTY = EmptyInvocationChain.new
  end
end
