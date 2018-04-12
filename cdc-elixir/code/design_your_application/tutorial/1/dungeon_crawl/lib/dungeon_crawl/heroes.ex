#---
# Excerpted from "Learn Functional Programming with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/cdc-elixir for more book information.
#---
defmodule DungeonCrawl.Heroes do
  alias DungeonCrawl.Character

  def all, do: [
    %Character{
      name: "Knight",
      description: "Knight has strong defense and consistent damage.",
      hit_points: 18,
      max_hit_points: 18,
      damage_range: 4..5,
      attack_description: "a sword"
    },
    %Character{
      name: "Wizard",
      description: "Wizard has strong attack, but low health.",
      hit_points: 8,
      max_hit_points: 8,
      damage_range: 6..10,
      attack_description: "a fireball"
    },
    %Character{
      name: "Rogue",
      description: "Rogue has high variability of attack damage.",
      hit_points: 12,
      max_hit_points: 12,
      damage_range: 1..12,
      attack_description: "a dagger"
    },
  ]
end
