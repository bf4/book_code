#---
# Excerpted from "Seven More Languages in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/7lang for more book information.
#---
defmodule States.Server do
  use GenServer # (1)
  require VidStore

  def start_link(videos) do # (2)
    GenServer.start_link(__MODULE__, videos, name: :video_store)
  end

  def init(videos) do # (3)
    { :ok, videos }
  end

  def handle_call({action, item}, _from, videos) do # (4)
    video = videos[item]
    new_video = apply VidStore, action, [video]
    { :reply, new_video, Keyword.put(videos, item, new_video) }
  end

  def handle_cast({ :add, video }, videos) do # (5)
    { :noreply, [video|videos] }
  end
end
