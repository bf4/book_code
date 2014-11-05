#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
inc = Proc.new {|x| x + 1 }
# more code...
inc.call(2) # => 3

require_relative "../test/assertions"
assert_equals 3, inc.call(2)

dec = lambda {|x| x - 1 }
dec.class # => Proc
dec.call(2) # => 1

assert_equals Proc, dec.class
assert_equals 1, dec.call(2)

p = proc {|x| x + 1 }
p.class # => Proc
