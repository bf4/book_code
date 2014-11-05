#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class Module
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