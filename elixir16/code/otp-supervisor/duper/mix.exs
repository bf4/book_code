#---
# Excerpted from "Programming Elixir ≥ 1.6",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/elixir16 for more book information.
#---
defmodule Duper.MixProject do
  use Mix.Project

  def project do
    [
      app:     :duper,
      version: "0.1.0",
      elixir:  "~> 1.6-dev",
      deps:    deps(),
      start_permanent: Mix.env() == :prod,
    ]
  end

  def application do
    [
      mod: {
        Duper.Application, []
      },
      extra_applications: [
        :logger
      ],
    ]
  end

  defp deps do
    [
      { :dir_walker, ">= 0.0.0" },
    ]
  end
end
