#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'markaby'

html = Markaby::Builder.new do
  head { title "My wonderful home page" }
  body do
    h1 "Welcome to my home page!"
    b "My hobbies:"
    ul do
      li "Juggling"
      li "Knitting"
      li "Metaprogramming"
    end
  end
end
