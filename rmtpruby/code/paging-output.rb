#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
def page_output
  stdout = STDOUT.clone

  less = open("|less", "w")
  STDOUT.reopen(less)

  at_exit do
    STDOUT.reopen(stdout)
    less.close
  end
end

page_output if STDOUT.tty?

500.times do |n|
  puts "#{n + 1}: Hello from Ruby"
  system "echo '#{n + 1}: Hello from a sub-shell'"
end
