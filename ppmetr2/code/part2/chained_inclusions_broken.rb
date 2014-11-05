#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module SecondLevelModule
  def self.included(base)
    base.extend ClassMethods
  end
  
  def second_level_instance_method; 'ok'; end
  
  module ClassMethods
    def second_level_class_method; 'ok'; end
  end
end

module FirstLevelModule
  def self.included(base)
    base.extend ClassMethods
  end
  
  def first_level_instance_method; 'ok'; end
  
  module ClassMethods
    def first_level_class_method; 'ok'; end
  end

  include SecondLevelModule
end

class BaseClass
  include FirstLevelModule
end

BaseClass.new.first_level_instance_method      # => "ok"
BaseClass.new.second_level_instance_method     # => "ok"

BaseClass.first_level_class_method             # => "ok"

require_relative '../test/assertions'
assert_equals "ok", BaseClass.new.first_level_instance_method
assert_equals "ok", BaseClass.new.second_level_instance_method
assert_equals "ok", BaseClass.first_level_class_method

begin
BaseClass.second_level_class_method            # => NoMethodError
fail
rescue; end
