#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module TestingSandbox
  # Temporarily replaces KCODE for the block
  def with_kcode(kcode)
    if RUBY_VERSION < '1.9'
      old_kcode, $KCODE = $KCODE, kcode
      begin
        yield
      ensure
        $KCODE = old_kcode
      end
    else
      yield
    end
  end
end
