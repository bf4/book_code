#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
def my_method(greeting)
  "#{greeting}, #{yield}!"
end

my_proc = proc { "Bill" }
my_method("Hello", &my_proc)

require_relative "../test/assertions"
assert_equals "Hello, Bill!", my_method("Hello", &my_proc)
