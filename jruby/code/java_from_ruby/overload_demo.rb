#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'java'
java_import 'OverloadDemo'

OverloadDemo.what_type_is 42       # => "long"
OverloadDemo.what_type_is "Fun!"   # => "string"
OverloadDemo.what_type_is Hash.new # => "object"
