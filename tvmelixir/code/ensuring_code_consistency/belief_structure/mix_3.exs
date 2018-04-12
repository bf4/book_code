#---
# Excerpted from "Adopting Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/tvmelixir for more book information.
#---
defmodule BeliefStructure.Mixfile do
  use Mix.Project

  def aliases do
    [
      "ensure_consistency": ["test", "dialyzer", "credo --strict", "inch",
                             "coveralls"]
    ]
  end
  def project do
    [
      app: :belief_structure,
      aliases: aliases(),
      preferred_cli_env: [
        "coveralls": :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "ensure_consistency": :test
      ],
      test_coverage: [tool: ExCoveralls],

      dialyzer: [plt_add_deps: :transitive],
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      version: "0.1.0"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo, "~> 0.8.8", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 0.5", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.7.4", only: [:test], runtime: false},
      {:ex_doc, "~> 0.18", only: [:dev], runtime: false},
      {:inch_ex, "~> 0.5", only: [:dev, :test], runtime: false}
    ]
  end
end
