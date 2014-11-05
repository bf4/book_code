#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class String
  def self.inherited(subclass)
    puts "#{self} was inherited by #{subclass}"
  end
end

class MyString < String; end

module M1
  def self.included(othermod)
    puts "M1 was included into #{othermod}"
  end
end

module M2
  def self.prepended(othermod)
    puts "M2 was prepended to #{othermod}"
  end
end

class C
  include M1
  prepend M2
end

module M
  def self.method_added(method)
    puts "New method: M##{method}"
  end
  
  def my_method; end
end
