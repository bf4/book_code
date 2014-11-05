#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class C
  def an_attribute
    @attr
  end
end

obj = C.new
a_variable = 100



# flat scope:
obj.instance_eval do
  @attr = a_variable
end

obj.an_attribute # => 100
