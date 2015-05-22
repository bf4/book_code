#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
defmodule Hub.Mixfile do
  use Mix.Project

  def project do
    [app: :hub,
     version: "0.0.1",
     elixir: "~> 1.0.0",
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.1.0"},
     {:poison, "~> 1.3.0"},
     {:httpotion, "~> 1.0.0"}]
  end
end
