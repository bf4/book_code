#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
defmodule Hub do
  HTTPotion.start
  @username "chrismccord"

  "https://api.github.com/users/#{@username}/repos"  
  |> HTTPotion.get(["User-Agent": "Elixir"])
  |> Map.get(:body)
  |> Poison.decode!
  |> Enum.each fn repo ->
    def unquote(String.to_atom(repo["name"]))() do
      unquote(Macro.escape(repo))                    
    end
  end

  def go(repo) do                                    
    url = apply(__MODULE__, repo, [])["html_url"]
    IO.puts "Launching browser to #{url}..."
    System.cmd("open", [url])
  end
end
