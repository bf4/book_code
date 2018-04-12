#---
# Excerpted from "Learn Functional Programming with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/cdc-elixir for more book information.
#---
defmodule DungeonCrawl.CLI.BaseCommands do
  alias Mix.Shell.IO, as: Shell

  def ask_for_option(options) do
    try do
      options
      |> display_options
      |> generate_question
      |> Shell.prompt
      |> parse_answer!
      |> find_option_by_index!(options)
    rescue
      e in DungeonCrawl.CLI.InvalidOptionError ->
        display_error(e)
        ask_for_option(options)
    end
  end

  def display_error(e) do
    Shell.cmd("clear")
    Shell.error(e.message)
    Shell.prompt("Press Enter to continue.")
    Shell.cmd("clear")
  end

  def parse_answer!(answer) do
    case Integer.parse(answer) do
      :error ->
        raise DungeonCrawl.CLI.InvalidOptionError
      {option, _} ->
        option - 1
    end
  end

  def find_option_by_index!(index, options) do
    Enum.at(options, index)
      || raise DungeonCrawl.CLI.InvalidOptionError
  end

  def display_options(options) do
    options
    |> Enum.with_index(1)
    |> Enum.each(fn {option, index} ->
      Shell.info("#{index} - #{DungeonCrawl.Display.info(option)}")
    end)

    options
  end

  def generate_question(options) do
    options = Enum.join(1..Enum.count(options),",")
    "Which one? [#{options}]\n"
  end
end
