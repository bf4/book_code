#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
require "test_helper"
require "fileutils"

class LiveAssetsTest < ActiveSupport::TestCase
  setup do
    FileUtils.mkdir_p "test/tmp"
  end

  teardown do
    FileUtils.rm_rf "test/tmp"
  end

  test "can subscribe to listener events" do
    # Create a listener
    l = LiveAssets.start_listener(:reload, ["test/tmp"])

    # Our subscriber is a simple array
    subscriber = []
    LiveAssets.subscribe(subscriber)

    begin
      while subscriber.empty?
        # Trigger changes in a file until we get an event
        File.write("test/tmp/sample", SecureRandom.hex(20))
      end

      assert_includes subscriber, :reload
    ensure
      # Clean up
      LiveAssets.unsubscribe(subscriber)
      l.kill
    end
  end

  test "can subscribe to existing reloadCSS events" do
    subscriber = []
    LiveAssets.subscribe(subscriber)

    begin
      while subscriber.empty?
        FileUtils.touch("test/dummy/app/assets/stylesheets/application.css")
      end

      assert_includes subscriber, :reloadCSS
    ensure
      LiveAssets.unsubscribe(subscriber)
    end
  end

  test "receives timer notifications" do
    # Create a timer
    l = LiveAssets.start_timer(:ping, 0.5)

    # Our subscriber is a simple array
    subscriber = []
    LiveAssets.subscribe(subscriber)

    begin
      # Wait until we get an event
      true while subscriber.empty?
      assert_includes subscriber, :ping
    ensure
      # Clean up
      LiveAssets.unsubscribe(subscriber)
    end
  end
end
