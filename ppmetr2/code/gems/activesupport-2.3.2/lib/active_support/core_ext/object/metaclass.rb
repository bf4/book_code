#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Object
  # Get object's meta (ghost, eigenclass, singleton) class
  def metaclass
    class << self
      self
    end
  end

  # If class_eval is called on an object, add those methods to its metaclass
  def class_eval(*args, &block)
    metaclass.class_eval(*args, &block)
  end
end
