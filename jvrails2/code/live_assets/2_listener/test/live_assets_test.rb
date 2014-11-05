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

      # Assert we got the event
      assert_includes subscriber, :reload
    ensure
      # Clean up
      LiveAssets.unsubscribe(subscriber)
      l.kill
    end
  end
end

class LiveAssetsTest < ActiveSupport::TestCase
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
end