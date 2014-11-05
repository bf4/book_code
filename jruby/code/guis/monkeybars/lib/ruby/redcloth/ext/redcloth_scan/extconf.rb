#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'mkmf'

$CFLAGS << " -O2 "

### It seems to work fine without these
# dir_config("redcloth_scan")
# have_library("c", "main")

create_makefile("redcloth_scan")
