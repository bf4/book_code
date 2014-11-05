#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'java'
require 'consumer.jar'

java_import 'Consumer'

consumer = Consumer.new
# ~> Consumer.java:2:in `<init>': java.lang.NoClassDefFoundError:
# ~>    Producer (NativeException)
# ~> 	...
# ~> 	from -:7
