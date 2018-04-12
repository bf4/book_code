#---
# Excerpted from "Learn Functional Programming with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/cdc-elixir for more book information.
#---
defmodule DepthNavigator do
  @max_depth 2

  def navigate(dir) do
    expanded_dir = Path.expand(dir)
    go_through([expanded_dir], 0)
  end

  defp go_through([], _current_depth), do: nil
  defp go_through(_dirs, current_depth) when current_depth > @max_depth, do: nil
  defp go_through([content | rest], current_depth) do
    print_and_navigate(content, File.dir?(content), current_depth)
    go_through(rest, current_depth)
  end

  defp print_and_navigate(_dir, false, _current_depth), do: nil
  defp print_and_navigate(dir, true, current_depth) do
    IO.puts dir
    children_dirs = File.ls!(dir)
    go_through(expand_dirs(children_dirs, dir), current_depth + 1)
  end

  defp expand_dirs([], _relative_to), do: []
  defp expand_dirs([dir | dirs], relative_to) do
    expanded_dir = Path.expand(dir, relative_to)
    [expanded_dir | expand_dirs(dirs, relative_to)]
  end
end
