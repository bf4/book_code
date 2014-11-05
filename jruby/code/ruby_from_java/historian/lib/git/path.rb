#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
module Git
  class Path
    
    attr_accessor :path
    
    def initialize(path, check_path = true)
      if !check_path || File.exists?(path)
        @path = File.expand_path(path)
      else
        raise ArgumentError, "path does not exist", File.expand_path(path)
      end
    end
    
    def readable?
      File.readable?(@path)
    end

    def writable?
      File.writable?(@path)
    end
    
    def to_s
      @path
    end
    
  end
end