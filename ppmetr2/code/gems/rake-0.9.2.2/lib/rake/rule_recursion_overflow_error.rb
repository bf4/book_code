#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---

module Rake

  # Error indicating a recursion overflow error in task selection.
  class RuleRecursionOverflowError < StandardError
    def initialize(*args)
      super
      @targets = []
    end

    def add_target(target)
      @targets << target
    end

    def message
      super + ": [" + @targets.reverse.join(' => ') + "]"
    end
  end

end
