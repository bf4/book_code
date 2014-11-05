#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'java'

java_import java.lang.System
System.currentTimeMillis # => 1251075795138

java_import java.lang.System
System.current_time_millis # => 1251075795172

factory = nil

java_import java.net.URL
# assume you've initialized some object "factory" here
URL.setURLStreamHandlerFactory(factory)
URL.set_urlstream_handler_factory(factory)

java_import java.util.logging.Logger
java_import java.util.logging.Level

Logger.global.log Level::SEVERE, "It looks like you're writing a letter!"
