#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'java'

java_import 'MethodClash'

the_clash = MethodClash.new

the_clash.java_send :initialize, [java.lang.String], 'everything'
# >> Now we're set up with everything

the_clash = MethodClash.new

the_clash.initialize 'everything'
# ~> -:8: wrong # of arguments(1 for 0) (ArgumentError)

