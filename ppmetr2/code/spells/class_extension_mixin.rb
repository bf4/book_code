#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module M
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def my_method
      'a class method'
    end
  end
end

class C
  include M
end

C.my_method # => "a class method"
