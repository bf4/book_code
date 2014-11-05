#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
module Git
  
  # object that holds all the available stashes
  class Stashes
    include Enumerable
    
    def initialize(base)
      @stashes = []
      
      @base = base
            
      @base.lib.stashes_all.each do |id, message|
        @stashes.unshift(Git::Stash.new(@base, message, true))
      end
    end
    
    def save(message)
      s = Git::Stash.new(@base, message)
      @stashes.unshift(s) if s.saved?
    end
    
    def apply(index=nil)
      @base.lib.stash_apply(index)
    end
    
    def clear
      @base.lib.stash_clear
      @stashes = []
    end

    def size
      @stashes.size
    end
    
    def each(&block)
      @stashes.each(&block)
    end
    
    def [](index)
      @stashes[index.to_i]
    end
    
  end
end
