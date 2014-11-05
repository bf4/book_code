#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class Class #:nodoc:
  def remove_subclasses
    Object.remove_subclasses_of(self)
  end

  def subclasses
    Object.subclasses_of(self).map { |o| o.to_s }
  end

  def remove_class(*klasses)
    klasses.flatten.each do |klass|
      # Skip this class if there is nothing bound to this name
      next unless defined?(klass.name)
      
      basename = klass.to_s.split("::").last
      parent = klass.parent
      
      # Skip this class if it does not match the current one bound to this name
      next unless parent.const_defined?(basename) && klass = parent.const_get(basename)
      
      parent.send :remove_const, basename unless parent == klass
    end
  end
end
