#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
defmodule Template do
  import Html

  def render do
    markup do
      div id: "main" do
        h1 class: "title" do
          text "Welcome!"
        end
      end
      div class: "row" do
        div do
          p do: text "Hello!"
        end
      end
    end
  end
end
