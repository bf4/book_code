#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module Printable
  # ...
end

module Document
  # ...
end

class Book
  include Printable
  include Document
  
  ancestors  # => [Book, Document, Printable, Object, Kernel, BasicObject]
end

require_relative "../test/assertions"
assert_equals [Book, Document, Printable, Object, Kernel, BasicObject], Book.ancestors
