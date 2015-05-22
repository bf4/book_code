#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
ARGF.each do |line|
  if ARGF.filename != "-" && ARGF.file.lineno == 1
    puts "\n#{ARGF.filename} (#{ARGF.file.size} bytes):\n\n"
  end

  puts line
end

