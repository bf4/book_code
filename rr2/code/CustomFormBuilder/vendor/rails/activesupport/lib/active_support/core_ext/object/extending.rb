#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class Object #:nodoc:
  def remove_subclasses_of(*superclasses)
    Class.remove_class(*subclasses_of(*superclasses))
  end

  def subclasses_of(*superclasses)
    subclasses = []
    ObjectSpace.each_object(Class) do |k|
      next if # Exclude this class if
        (k.ancestors & superclasses).empty? || # It's not a subclass of our supers
        superclasses.include?(k) || # It *is* one of the supers
        eval("! defined?(::#{k})") || # It's not defined.
        eval("::#{k}").object_id != k.object_id
      subclasses << k
    end
    subclasses
  end
  
  def extended_by
    ancestors = class << self; ancestors end
    ancestors.select { |mod| mod.class == Module } - [ Object, Kernel ]
  end
  
  def copy_instance_variables_from(object, exclude = [])
    exclude += object.protected_instance_variables if object.respond_to? :protected_instance_variables
    
    instance_variables = object.instance_variables - exclude.map { |name| name.to_s }
    instance_variables.each { |name| instance_variable_set(name, object.instance_variable_get(name)) }
  end
  
  def extend_with_included_modules_from(object)
    object.extended_by.each { |mod| extend mod }
  end

  def instance_values
    instance_variables.inject({}) do |values, name|
      values[name[1..-1]] = instance_variable_get(name)
      values
    end
  end
  
  unless defined? instance_exec # 1.9
    def instance_exec(*arguments, &block)
      block.bind(self)[*arguments]
    end
  end
end
