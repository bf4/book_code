#---
# Excerpted from "Programming Elixir ≥ 1.6",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/elixir16 for more book information.
#---
defmodule Pbt.Mixfile do
  use Mix.Project

  def project do
    [
      app:             :pbt,
      version:         "0.1.0",
      elixir:          ">= 1.6.0-dev",
      start_permanent: Mix.env == :prod,
      deps:            deps()
    ]
  end

  def application do
    [
      applications: [
        :logger,
        :stream_data,
      ]
    ]
  end

  defp deps do
    [
      { :stream_data, ">= 0.0.0" },
    ]
  end
end
