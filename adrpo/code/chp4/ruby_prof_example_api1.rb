#---
# Excerpted from "Ruby Performance Optimization",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/adrpo for more book information.
#---
require 'date'
require 'rubygems'
require 'ruby-prof'

GC.disable

RubyProf.start
Date.parse("2014-07-01")
result = RubyProf.stop

printer = RubyProf::FlatPrinter.new(result)
printer.print(File.open("ruby_prof_example_api1_profile.txt", "w+"))
