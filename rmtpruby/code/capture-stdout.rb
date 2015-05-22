#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
require "stringio"

def capture_output(&block)
  old_stdout = $stdout
  new_stdout = StringIO.new

  $stdout = new_stdout
  block.call

  new_stdout.string
ensure
  $stdout = old_stdout
end

output = capture_output do
  puts "Hello, world"
end

puts output.upcase

output = capture_output do
  puts "Hello, world"
  system "echo 'Hello, world'"
end

puts output.upcase

