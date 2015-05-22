#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
# encoding: utf-8
string = "Hëlló Wôrld".encode("US-ASCII", undef: :replace, replace: "")

string.encoding # => #<Encoding:US-ASCII>
string # => "Hll Wrld"

