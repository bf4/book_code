#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module Builder
  VERSION_NUMBERS = [
    VERSION_MAJOR = 3,
    VERSION_MINOR = 2,
    VERSION_BUILD = 2,
  ]
  VERSION = VERSION_NUMBERS.join(".")
end
