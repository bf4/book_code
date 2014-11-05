#---
# Excerpted from "Programming Ruby 1.9 and 2.0",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ruby4 for more book information.
#---
# The regexp in this file is wrapped in a method
# to allow it to be required into other files. This
# is purely an artifact of the way we build the
# Ruby book.

def palindrome_matcher
palindrome_matcher = /
\A
  (?<palindrome>
                # nothing, or
   | \w         # a single character, or
   | (?:        # x <palindrome> x
       (?<some_letter>\w)
       \g<palindrome>
       \k<some_letter+0>
     )
  )
\z
/x
end
