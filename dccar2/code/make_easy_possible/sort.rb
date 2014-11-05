#!/usr/bin/env ruby
#---
# Excerpted from "Build Awesome Command-Line Applications in Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dccar2 for more book information.
#---
def read_file(io,lines)
  io.readlines.each { |line| lines << line.chomp }
end
lines = []
if ARGV.empty?
  read_file(STDIN,lines)
else
  ARGV.each { |file| read_file(File.open(file),lines) }
end
puts lines.sort.join("\n")
