#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class C
  def method_missing(name, *args)
    "a Ghost Method"
  end
end

obj = C.new
obj.to_s # => "#<C:0x007fbb2a10d2f8>"

class D < BasicObject
  def method_missing(name, *args)
    "a Ghost Method"
  end
end

blank_slate = D.new
blank_slate.to_s # => "a Ghost Method"
