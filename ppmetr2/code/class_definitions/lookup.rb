#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class C
  def a_method
    'C#a_method()'
  end
end

class D < C; end

obj = D.new
obj.a_method    # => "C#a_method()"

require_relative '../test/assertions'
assert_equals "C#a_method()", obj.a_method

class << obj
  def a_singleton_method
    'obj#a_singleton_method()'
  end
end

assert_equals "obj#a_singleton_method()", obj.a_singleton_method

obj.singleton_class.superclass   # => D

assert_equals D, obj.singleton_class.superclass

class C
  class << self
    def a_class_method
      'C.a_class_method()'
    end
  end
end

assert_equals "C.a_class_method()", C.a_class_method

C.singleton_class              # => #<Class:C>
D.singleton_class              # => #<Class:D>
D.singleton_class.superclass   # => #<Class:C>
C.singleton_class.superclass   # => #<Class:Object>

assert_equals "#<Class:C>", C.singleton_class.to_s
assert_equals "#<Class:D>", D.singleton_class.to_s
assert_equals "#<Class:C>", D.singleton_class.superclass.to_s
assert_equals "#<Class:Object>", C.singleton_class.superclass.to_s

D.a_class_method          # => "C.a_class_method()"

assert_equals "C.a_class_method()", D.a_class_method
