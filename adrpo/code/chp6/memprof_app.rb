#---
# Excerpted from "Ruby Performance Optimization",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/adrpo for more book information.
#---
require 'rubygems'
require 'ruby-prof'
require 'benchmark'

exit(0) unless ARGV[0]

GC.enable_stats
RubyProf.measure_mode = RubyProf.const_get(ARGV[0])

result = RubyProf.profile do

  str = 'x'*1024*1024*10
  str.upcase

end

printer = RubyProf::FlatPrinter.new(result)
printer.print(File.open("#{ARGV[0]}_profile.txt", "w+"), min_percent: 1)

printer = RubyProf::CallTreePrinter.new(result)
printer.print(File.open("callgrind.out.memprof_app", "w+"))
