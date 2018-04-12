#---
# Excerpted from "Learn Functional Programming with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/cdc-elixir for more book information.
#---
defmodule DungeonCrawl.CLI.RoomActionsChoice do
  alias Mix.Shell.IO, as: Shell
  import DungeonCrawl.CLI.BaseCommands

  def start(room) do
    room_actions = room.actions
    find_action_by_index = &(Enum.at(room_actions, &1))

    Shell.info(room.description())

    chosen_action =
      room_actions
      |> display_options
      |> generate_question
      |> Shell.prompt
      |> parse_answer
      |> find_action_by_index.()

    {room, chosen_action}
  end
end
