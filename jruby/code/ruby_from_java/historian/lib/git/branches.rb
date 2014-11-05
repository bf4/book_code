#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
module Git
  
  # object that holds all the available branches
  class Branches
    include Enumerable
    
    def initialize(base)
      @branches = {}
      
      @base = base
            
      @base.lib.branches_all.each do |b|
        @branches[b[0]] = Git::Branch.new(@base, b[0])
      end
    end

    def local
      self.select { |b| !b.remote }
    end
    
    def remote
      self.select { |b| b.remote }
    end
    
    # array like methods

    def size
      @branches.size
    end    
    
    def each(&block)
      @branches.values.each(&block)
    end
    
    def [](symbol)
      @branches[symbol.to_s]
    end
    
    def to_s
      out = ''
      @branches.each do |k, b|
        out << (b.current ? '* ' : '  ') << b.to_s << "\n"
      end
      out
    end
    
  end
end
