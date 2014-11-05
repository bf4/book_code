#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
require "test_helper"
require "thread"
class LiveAssets::SubscriberTest < ActiveSupport::TestCase
  test "yields server sent events from the queue" do
    # Let's start our queue with some events
    queue = Queue.new
    queue << :reloadCSS
    queue << :ping
    queue << nil

    # And create a subscriber on top of it
    subscriber = LiveAssets::SSESubscriber.new(queue)
    stream = []
    subscriber.each do |msg|
      stream << msg
    end
    assert_equal 2, stream.length
    assert_includes stream, "event: reloadCSS\ndata: {}\n\n"
    assert_includes stream, "event: ping\ndata: {}\n\n"
  end
end
