#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'active_support'

module MyConcern
  extend ActiveSupport::Concern
  
  def an_instance_method; "an instance method"; end
  
  module ClassMethods
    def a_class_method; "a class method"; end
  end
end

class MyClass
  include MyConcern
end

MyClass.new.an_instance_method  # => "an instance method"
MyClass.a_class_method          # => "a class method"

require_relative '../test/assertions'
assert_equals "an instance method", MyClass.new.an_instance_method
assert_equals "a class method", MyClass.a_class_method
