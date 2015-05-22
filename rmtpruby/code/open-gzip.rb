#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
open("|gzip", "r+") do |gzip|
  gzip.puts "foo"

  gzip.close_write

  File.open("foo.gz", "w") do |file|
    file.write gzip.read
  end
end
