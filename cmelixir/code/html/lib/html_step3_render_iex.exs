#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
iex> c "html_step3.exs"
[Html]

iex> c "html_step3_render.exs"
[Template]

iex> Template.render
"<div id=\"main\"><h1 class=\"title\">Welcome!</h1>
</div><div class=\"row\"><div><p>Hello!</p></div></div>"
