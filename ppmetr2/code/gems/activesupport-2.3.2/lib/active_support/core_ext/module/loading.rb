#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Module
  # Returns String#underscore applied to the module name minus trailing classes.
  #
  #   ActiveRecord.as_load_path               # => "active_record"
  #   ActiveRecord::Associations.as_load_path # => "active_record/associations"
  #   ActiveRecord::Base.as_load_path         # => "active_record" (Base is a class)
  #
  # The Kernel module gives an empty string by definition.
  #
  #   Kernel.as_load_path # => ""
  #   Math.as_load_path   # => "math"
  def as_load_path
    if self == Object || self == Kernel
      ''
    elsif is_a? Class
      parent == self ? '' : parent.as_load_path
    else
      name.split('::').collect do |word|
        word.underscore
      end * '/'
    end
  end
end