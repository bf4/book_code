#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
module Git
  class Author
    attr_accessor :name, :email, :date
    
    def initialize(author_string)
      if m = /(.*?) <(.*?)> (\d+) (.*)/.match(author_string)
        @name = m[1]
        @email = m[2]
        @date = Time.at(m[3].to_i)
      end
    end
    
  end
end