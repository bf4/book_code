#---
# Excerpted from "Programming Ruby 1.9 and 2.0",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ruby4 for more book information.
#---
require 'abbrev'
require 'readline'
include Readline

ABBREV = %w{ exit inc dec }.abbrev
Readline.completion_proc = -> string { ABBREV[string] }

value = 0
loop do
  cmd = readline("wibble [#{value}]: ", true) || "exit"
  case cmd.strip
  when "exit"   then break
  when "inc"    then value += 1
  when "dec"    then value -= 1
  else               puts "Invalid command #{cmd}"
  end
end
