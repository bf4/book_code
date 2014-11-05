#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module Sprockets
  class NullCompressor
    def compress(content)
      content
    end
  end

  class LazyCompressor
    def initialize(&block)
      @block = block
    end

    def compressor
      @compressor ||= @block.call || NullCompressor.new
    end

    def compress(content)
      compressor.compress(content)
    end
  end
end