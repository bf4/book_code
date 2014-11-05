#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class MyDynamicProxy
  def initialize(target)
    @target = target
  end
  
  def method_missing(name, *args, &block)
    "result: #{@target.send(name, *args, &block)}"
  end          
end

obj = MyDynamicProxy.new("a string")
obj.reverse # => "result: gnirts a"
