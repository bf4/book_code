#---
# Excerpted from "Seven More Languages in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/7lang for more book information.
#---
defmodule ConcreteTest do
  use ExUnit.Case
  import Should

  should "update count" do
      rented_video = VideoStore.renting(video)
      assert rented_video.times_rented == 1
  end

  should "rent video" do
    rented_video = VideoStore.Concrete.rent video
    assert :rented == rented_video.state
    assert 1 == Enum.count( rented_video.log )
  end

  should "handle multiple
 transitions" do
    import VideoStore.Concrete
    vid = video |> rent |> return |> rent |> return |> rent
    assert 5 == Enum.count( vid.log )
    assert 3 == vid.times_rented
  end

  def video, do: %Video{title: "XMen"}
end
