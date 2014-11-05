#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
lambda {
  shared = 10
  self.class.class_eval do
    define_method :counter do
      shared
    end
    define_method :down do
      shared -= 1
    end
  end
}.call

counter           # => 10
3.times { down }
counter           # => 7
