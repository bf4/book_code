#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module VCR
  # @private
  module VariableArgsBlockCaller
    def call_block(block, *args)
      if block.arity >= 0
        args = args.first([args.size, block.arity].min)
      end

      block.call(*args)
    end
  end
end

