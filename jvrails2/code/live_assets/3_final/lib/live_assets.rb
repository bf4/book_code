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

  @@mutex = Mutex.new
  def self.subscribe(subscriber)
    @@mutex.synchronize do
      subscribers << subscriber
    end
  end
  def self.unsubscribe(subscriber)
    @@mutex.synchronize do
      subscribers.delete(subscriber)
    end
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

  def self.start_timer(event, time)
    Thread.new do
      while true
        subscribers.each { |s| s << event }
        sleep(time)
      end
    end
  end
end

module LiveAssets
  extend ActiveSupport::Autoload

  eager_autoload do
    autoload :SSESubscriber
  end
end
