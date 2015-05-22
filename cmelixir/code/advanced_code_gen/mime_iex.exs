#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
iex> c "mime.exs"
[Mime]

iex> Mime.exts_from_type("image/jpeg") 
[".jpeg", ".jpg"]

iex> Mime.type_from_ext(".jpg")        
"image/jpeg"

iex> Mime.valid_type?("text/html")     
true

iex> Mime.valid_type?("text/emoji")
false
