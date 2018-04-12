#---
# Excerpted from "Learn Functional Programming with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/cdc-elixir for more book information.
#---
defmodule TicTacToe do
  def winner({
    x, x, x,
    _, _, _,
    _, _, _
  }), do: {:winner, x}

  def winner({
    _, _, _,
    x, x, x,
    _, _, _
  }), do: {:winner, x}

  def winner({
    _, _, _,
    _, _, _,
    x, x, x
  }), do: {:winner, x}

  def winner({
    x, _, _,
    x, _, _,
    x, _, _
  }), do: {:winner, x}

  def winner({
    _, x, _,
    _, x, _,
    _, x, _
  }), do: {:winner, x}

  def winner({
    _, _, x,
    _, _, x,
    _, _, x
  }), do: {:winner, x}

  def winner({
    x, _, _,
    _, x, _,
    _, _, x
  }), do: {:winner, x}

  def winner({
    _, _, x,
    _, x, _,
    x, _, _
  }), do: {:winner, x}

  def winner(_board), do: :no_winner
end
