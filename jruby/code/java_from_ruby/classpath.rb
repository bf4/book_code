#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
$CLASSPATH ||= []

$CLASSPATH << '/usr/local/lib/jemmy/jemmy.jar'

require '/usr/local/lib/jemmy/jemmy.jar'

$LOAD_PATH << '/usr/local/lib/jemmy'
require 'jemmy.jar'
