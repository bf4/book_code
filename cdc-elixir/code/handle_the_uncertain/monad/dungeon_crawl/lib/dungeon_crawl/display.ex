#---
# Excerpted from "Learn Functional Programming with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/cdc-elixir for more book information.
#---
defprotocol DungeonCrawl.Display do
  def info(value)
end

defimpl DungeonCrawl.Display, for: DungeonCrawl.Room.Action do
  def info(action), do: action.label
end

defimpl DungeonCrawl.Display, for: DungeonCrawl.Character do
  def info(character), do: character.name
end
