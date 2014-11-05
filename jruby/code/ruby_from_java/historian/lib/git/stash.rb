#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
module Git
  class Stash
    
    def initialize(base, message, existing=false)
      @base = base
      @message = message
      save unless existing
    end
    
    def save
      @saved = @base.lib.stash_save(@message)
    end
    
    def saved?
      @saved
    end
    
    def message
      @message
    end
    
    def to_s
      message
    end
    
  end
end