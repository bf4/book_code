#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
def sandbox(&code)
  proc {
    $SAFE = 2
    yield
  }.call
end
begin
  sandbox { File.delete 'a_file' }
rescue Exception => ex
  ex   # => #<SecurityError: Insecure operation at level 2>
end
