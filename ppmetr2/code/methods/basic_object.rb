#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
im = BasicObject.instance_methods
im # => [:==, :equal?, :!, :!=, :instance_eval, :instance_exec, :__send__, :__id__]

require_relative '../test/assertions'
assert_equals [:==, :equal?, :!, :!=, :instance_eval, :instance_exec, :__send__, :__id__], BasicObject.instance_methods
