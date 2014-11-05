#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Module
  # Declare an attribute accessor with an initial default return value.
  #
  # To give attribute <tt>:age</tt> the initial value <tt>25</tt>:
  #  
  #   class Person
  #     attr_accessor_with_default :age, 25
  #   end
  #
  #   some_person.age
  #   => 25
  #   some_person.age = 26
  #   some_person.age
  #   => 26
  #
  # To give attribute <tt>:element_name</tt> a dynamic default value, evaluated
  # in scope of self:
  #
  #   attr_accessor_with_default(:element_name) { name.underscore } 
  #
  def attr_accessor_with_default(sym, default = nil, &block)
    raise 'Default value or block required' unless !default.nil? || block
    define_method(sym, block_given? ? block : Proc.new { default })
    module_eval(<<-EVAL, __FILE__, __LINE__)
      def #{sym}=(value)                        # def age=(value)
        class << self; attr_reader :#{sym} end  #   class << self; attr_reader :age end
        @#{sym} = value                         #   @age = value
      end                                       # end
    EVAL
  end
end
