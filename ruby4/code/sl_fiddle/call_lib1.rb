#---
# Excerpted from "Programming Ruby 1.9 and 2.0",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ruby4 for more book information.
#---
require 'dl/import'

module Message
  extend DL::Importer
  dlload "lib.so"
  extern "int print_msg(char *, int)"
end

msg_size = Message.print_msg("Answer", 42)
puts "Just wrote #{msg_size} bytes"
