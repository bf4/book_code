#---
# Excerpted from "Programming Ruby 1.9 and 2.0",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ruby4 for more book information.
#---
# encoding: sjis

require_relative 'iso-8859-1'
require_relative 'utf'

def show_encoding(str)
  puts "'#{str.bytes.to_a}' (#{str.size} chars, #{str.bytesize} bytes) " +
        "has encoding #{str.encoding.name}"
end

show_encoding(STRING_ISO)
show_encoding(STRING_U)  
show_encoding("cat")
