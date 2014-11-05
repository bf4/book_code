#---
# Excerpted from "Programming Ruby 1.9 and 2.0",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ruby4 for more book information.
#---
require 'coverage'
Coverage.start
STDOUT.reopen("/dev/null")
require_relative 'fizzbuzz.rb'
Coverage.result.each do |file_name, counts|
  File.readlines(file_name).each.with_index do |code_line, line_number|
    count = counts[line_number] || "--"
    STDERR.printf "%3s: %s", count, code_line
  end
end
  
