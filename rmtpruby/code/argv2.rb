#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
options = { v: false }

ARGV.delete_if do |a|
  a.start_with?("-") &&
    options[a.sub(/^-/, "").to_sym] = true
end

ARGF.each do |line|
  puts line
end
