#---
# Excerpted from "Learn Functional Programming with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/cdc-elixir for more book information.
#---
defmodule DungeonCrawl.Battle do
  alias DungeonCrawl.Character
  alias Mix.Shell.IO, as: Shell

  def fight(
    char_a = %{hit_points: hit_points_a},
    char_b = %{hit_points: hit_points_b}
  ) when hit_points_a == 0 or hit_points_b == 0, do: {char_a, char_b}
  def fight(char_a, char_b) do
    char_b_after_damage = attack(char_a, char_b)
    char_a_after_damage = attack(char_b_after_damage, char_a)
    fight(char_a_after_damage, char_b_after_damage)
  end

  defp attack(%{hit_points: hit_points_a}, character_b)
    when hit_points_a == 0, do: character_b
  defp attack(char_a, char_b) do
    damage = Enum.random(char_a.damage_range)
    char_b_after_damage = Character.take_damage(char_b, damage)

    char_a
      |> attack_message(damage)
      |> Shell.info

    char_b_after_damage
      |> receive_message(damage)
      |> Shell.info

    char_b_after_damage
  end

  defp attack_message(character = %{name: "You"}, damage) do
    "You attack with #{character.attack_description} " <>
    "and deal #{damage} damage."
  end
  defp attack_message(character, damage) do
    "#{character.name} attacks with " <>
    "#{character.attack_description} and " <>
    "deals #{damage} damage."
  end

  defp receive_message(character = %{name: "You"}, damage) do
    "You receive #{damage}. Current HP: #{character.hit_points}."
  end
  defp receive_message(character, damage) do
    "#{character.name} receives #{damage}. " <>
    "Current HP: #{character.hit_points}."
  end
end
