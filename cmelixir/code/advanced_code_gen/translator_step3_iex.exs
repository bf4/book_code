#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
iex> c "translator.exs"
[Translator]

iex> c "i18n.exs"
[I18n]

iex> I18n.t("en", "flash.hello", first: "Chris", last: "McCord")
{:error, :no_translation}

iex> I18n.t("en", "flash.hello")
{:error, :no_translation}
