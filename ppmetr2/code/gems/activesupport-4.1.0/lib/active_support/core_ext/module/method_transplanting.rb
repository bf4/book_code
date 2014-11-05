#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Module
  ###
  # TODO: remove this after 1.9 support is dropped
  def methods_transplantable? # :nodoc:
    x = Module.new { def foo; end }
    Module.new { define_method :bar, x.instance_method(:foo) }
    true
  rescue TypeError
    false
  end
end
