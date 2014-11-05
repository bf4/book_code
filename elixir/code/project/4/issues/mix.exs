#---
# Excerpted from "Programming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/elixir for more book information.
#---
defmodule Issues.Mixfile do
  use Mix.Project

  def project do
    [ app:     :issues,
      version: "0.0.1",
      elixir:  ">= 0.0.0",
      escript: escript_config,
      deps:    deps ]
  end

  # Configuration for the OTP application
  def application do
    [ 
      applications: [ :logger, :httpoison, :jsx ] 
    ]
  end

  defp deps do
    [
      { :httpoison, "~> 0.4" },
      { :jsx,       "~> 2.0" }
    ]
  end

  defp escript_config do
    [ main_module: Issues.CLI ]
  end
end
