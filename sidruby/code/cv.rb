#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
class A
  @@a = 'Aa'
  @b = 'Ab'

  def self.b
    @b
  end
  
  def foo
    p [@@a, self.class.b]
  end
end

class B < A
  @@a = 'Ba'
  @b = 'Bb'
end

A.new.foo
B.new.foo
