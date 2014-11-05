#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class Module
  # Return the module which contains this one; if this is a root module, such as
  # +::MyModule+, then Object is returned.
  def parent
    parent_name = name.split('::')[0..-2] * '::'
    parent_name.empty? ? Object : parent_name.constantize
  end
  
  # Return all the parents of this module, ordered from nested outwards. The
  # receiver is not contained within the result.
  def parents
    parents = []
    parts = name.split('::')[0..-2]
    until parts.empty?
      parents << (parts * '::').constantize
      parts.pop
    end
    parents << Object unless parents.include? Object
    parents
  end
end
