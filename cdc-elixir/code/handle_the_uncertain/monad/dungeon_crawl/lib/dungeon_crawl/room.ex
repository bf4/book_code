#---
# Excerpted from "Learn Functional Programming with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/cdc-elixir for more book information.
#---
defmodule DungeonCrawl.Room do
  alias DungeonCrawl.Room.Triggers
  alias DungeonCrawl.Room

  import DungeonCrawl.Room.Action

  defstruct description: nil, actions: [], trigger: nil
  @type t :: %Room{
    description: String.t,
    actions: [DungeonCrawl.Room.Action.t],
    trigger: module
  }

  def all, do: [
    %Room{
      description: "You can see an enemy blocking your path.",
      actions: [forward()],
      trigger: Triggers.Enemy
    },
    %Room{
      description: "You can see the light of day. You found the exit!",
      actions: [forward()],
      trigger: Triggers.Exit
    },
    %Room{
      description: "You found a quiet place. Looks safe for a little nap.",
      actions: [forward(), rest()],
      trigger: Triggers.Rest
    },
    %Room{
      description: "You found a quiet place. Looks safe for a little nap.",
      actions: [forward(), rest()],
      trigger: Triggers.EnemyHidden
    },
    %Room{
      description: "You arrived in a dark place. Your eyes almost can't see what's in front of you.",
      actions: [forward(), search()],
      trigger: Triggers.Trap
    },
    %Room{
      description: "You arrived in a dark place. Your eyes almost can't see what's in front of you.",
      actions: [forward(), search()],
      trigger: Triggers.Treasure
    }
  ]

  def start_rooms, do: Enum.reject(all(), &(&1.trigger == Triggers.Exit))
end
