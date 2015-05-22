#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
# encoding: utf-8
File.open("western-european.txt", "r:iso-8859-1") do |file|
  file.external_encoding # => #<Encoding:ISO-8859-1>
  contents = file.read # => "This file contains some ISO-8859-1 text.\n"
  contents.encoding # => #<Encoding:ISO-8859-1>
end

