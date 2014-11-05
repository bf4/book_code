#---
# Excerpted from "Seven More Languages in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/7lang for more book information.
#---
defmodule Should do
  defmacro should(name, options) do
    quote do
      test("should #{unquote name}", unquote(options))
    end
  end
end

ExUnit.start
