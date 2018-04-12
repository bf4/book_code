#---
# Excerpted from "Learn Functional Programming with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/cdc-elixir for more book information.
#---
defmodule DungeonCrawl.Enemies do
  alias DungeonCrawl.Character

  def all, do: [
    %Character{
      name: "Ogre",
      description: "A large creature. Big muscles. Angry and hungry.",
      hit_points: 12,
      max_hit_points: 12,
      damage_range: 3..5,
      attack_description: "a hammer"
    },
    %Character{
      name: "Orc",
      description: "A green evil creature. Wears armor and an axe.",
      hit_points: 8,
      max_hit_points: 8,
      damage_range: 2..4,
      attack_description: "an axe"
    },
    %Character{
      name: "Goblin",
      description: "A small green creature. Wears dirty clothes and a dagger.",
      hit_points: 4,
      max_hit_points: 4,
      damage_range: 1..2,
      attack_description: "a dagger"
    },
  ]
end
