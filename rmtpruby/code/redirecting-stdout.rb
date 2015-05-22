#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
def capture_output(&block)
  stdout = STDOUT.clone

  read_io, write_io = IO.pipe
  read_io.sync = true

  output = ""
  reader = Thread.new do
    begin
      loop do
        output << read_io.readpartial(1024)
      end
    rescue EOFError
    end
  end

  STDOUT.reopen(write_io)
  block.call
ensure
  STDOUT.reopen(stdout)
  write_io.close
  reader.join

  return output
end

output = capture_output do
  puts "Hello, world"
  system "echo 'Hello, world'"
end

puts output.upcase

