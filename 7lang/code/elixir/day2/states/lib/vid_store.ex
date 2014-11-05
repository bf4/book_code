#---
# Excerpted from "Seven More Languages in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/7lang for more book information.
#---
defmodule VidStore do
  use StateMachine

  state :available, 
     rent: [ to: :rented,      calls: [ &VidStore.renting/1 ]]

  state :rented, 
     return: [ to: :available, calls: [ &VidStore.returning/1 ]],
     lose:   [ to: :lost,      calls: [ &VidStore.losing/1 ]]

  state :lost, []


  def renting(video) do # (1)
    rented_video = log video, "Renting #{video.title}"
    %{rented_video | times_rented: video.times_rented + 1}
  end

  def returning(video), do: log( video, "Returning #{video.title}" )

  def losing(video), do: log( video, "Losing #{video.title}" )

  def log(video, message) do
    %{video | log: [message|video.log]}
  end
end
