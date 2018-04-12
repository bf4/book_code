#---
# Excerpted from "Adopting Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/tvmelixir for more book information.
#---
defmodule NameAndPort do
  # The current distribution protocol version.
  @protocol_version 5
  def start_link do
    :ignore
  end
  def register_node(_name, _port, _version) do
    {:ok, :rand.uniform(3)}
  end
  def port_please(name, _ip) do
    shortname = name |> to_string() |> String.split("@") |> hd()

    with [_prefix, port_string] <- String.split(shortname, "-"),
         {port, ""} <- Integer.parse(port_string) do
      {:port, port, @protocol_version}
    else
      _ -> :noport
    end
  end
  def names(_hostnames) do
    {:error, :no_epmd}
  end
end
