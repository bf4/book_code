#!/usr/bin/env ruby
#---
# Excerpted from "Deploying with JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jkdepj for more book information.
#---
ENV["RAILS_ENV"] ||= "production"

# load the rails environment
require File.dirname(__FILE__) + "/../../config/environment"

$running = true
Signal.trap("TERM") do
  $running = false
end

with_twitter_client do |client, keywords|
  thread = Thread.new do
    client.track(*keywords) do |status|
      puts "[#{status.user.screen_name}] #{status.text}"
      Status.create(
          :screen_name => status.user.screen_name,
          :status_text => status.text)
    end
  end

  while($running) do
    sleep 20
  end

  client.stop
  thread.join
end