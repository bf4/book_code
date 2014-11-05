#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
require "live_assets/engine"
require "thread"
require "listen"
module LiveAssets
  mattr_reader :subscribers
  @@subscribers = []
  # Subscribe to all published events.
  def self.subscribe(subscriber)
    subscribers << subscriber
  end
  # Unsubscribe an existing subscriber.
  def self.unsubscribe(subscriber)
    subscribers.delete(subscriber)
  end
  # Start a listener for the following directories.
  # Every time a change happens, publish the given
  # event to all subscribers available.
  def self.start_listener(event, directories)
    Thread.new do
      Listen.to(*directories, latency: 0.5) do |_modified, _added, _removed|
        subscribers.each { |s| s << event }
      end
    end
  end
end

module LiveAssets
  autoload :SSESubscriber, "live_assets/sse_subscriber"
end
