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
(
  def(t(locale, path, bindings \\ []))
  [[[def(t("fr", "flash.hello", bindings)) do
    "Salut %{first} %{last}!"
  end, def(t("fr", "flash.bye", bindings)) do
    "Au revoir, %{name}!"
  end], [def(t("fr", "users.title", bindings)) do
    "Utilisateurs"
  end]], [[def(t("en", "flash.hello", bindings)) do
    "Hello %{first} %{last}!"
  end, def(t("en", "flash.bye", bindings)) do
    "Bye, %{name}!"
  end], [def(t("en", "users.title", bindings)) do
    "Users"
  end]]]
  def(t(_locale, _path, _bindings)) do
    {:error, :no_translation}
  end
)
[I18n]
iex>
