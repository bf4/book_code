#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
iex> c "html_step2.exs"
[Html]

iex> c "html_step2_render.exs"
[Template]

iex> Template.render
"<table><tr><td>Cell 0</td><td>Cell 1</td><td>Cell 2</td><td>Cell 3</td>
<td>Cell 4</td><td>Cell 5</td></tr></table><div>Some Nested Content</div>"
