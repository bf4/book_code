#---
# Excerpted from "Learn Functional Programming with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/cdc-elixir for more book information.
#---
defmodule MyString do
  def capitalize_words(title) do
    words = String.split(title)
    capitalized_words = Enum.map(words, &String.capitalize/1)
    Enum.join(capitalized_words, " ")
  end

  def capitalize_words(title) do
    Enum.join(
      Enum.map(
        String.split(title),
        &String.capitalize/1
      ), " "
    )
  end

  def capitalize_words(title) do
    title
    |> String.split
    |> capitalize_all
    |> join_with_whitespace
  end

  def capitalize_all(words) do
    Enum.map(words, &String.capitalize/1)
  end

  def join_with_whitespace(words) do
    Enum.join(words, " ")
  end

  def capitalize_words(title) do
    title
    |> String.split
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(" ")
  end
end
