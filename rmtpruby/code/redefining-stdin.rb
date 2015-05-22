#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
require "stringio"

io = StringIO.new("The quick brown fox\nJumped over the lazy dog.")
$stdin = io

puts $stdin.gets # => The quick brown fox
puts $stdin.gets # => Jumped over the lazy dog.
