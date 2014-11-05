#---
# Excerpted from "Seven More Languages in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/7lang for more book information.
#---
defmodule VideoStore do
  def renting(video) do
    vid = log video, "Renting #{video.title}"
    %{vid | times_rented: (video.times_rented + 1)}
  end

  def returning(video), do: log( video, "Returning #{video.title}" )

  def losing(video), do: log( video, "Losing #{video.title}" )

  def log(video, message) do
    %{video | log: [message|video.log]}
  end
end
