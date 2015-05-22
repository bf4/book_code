#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
# defmodule Html.Template do
#
#   def render do
#     import Html
#     markup do
#       div do
#         h1 class: "hello" do
#           text "hello!"
#         end
#       end
#       h1 do: text("Welcome")
#       tag :div do
#         text "hello"
#         tag :span do
#           text "there"
#         end
#       end
#       tag :input, type: "text", name: "email"
#
#       tag :table do
#         tag :tr do
#           tag :td, do: text 1
#           tag :td, do: text 2
#           tag :td, do: text 3
#           tag :td, do: text 4
#         end
#       end
#
#       ul do
#         for x <- 1..10 do
#           li do: text(x)
#         end
#       end
#     end |> IO.inspect
#
#   end
# end
