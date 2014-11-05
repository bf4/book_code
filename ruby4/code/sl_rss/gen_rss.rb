#---
# Excerpted from "Programming Ruby 1.9 and 2.0",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ruby4 for more book information.
#---
require 'rss/0.9'

rss  = RSS::Rss.new("0.9")
chan = RSS::Rss::Channel.new
chan.title       = "The Daily Dave"
chan.description = "Dave's Feed"
chan.language    = "en-US"
chan.link        = "http://pragdave.pragprog.com"
rss.channel      = chan

image = RSS::Rss::Channel::Image.new
image.url   = "http://pragprog.com/pragdave.gif"
image.title = "PragDave"
image.link  = chan.link
chan.image  = image

3.times do |i|
  item = RSS::Rss::Channel::Item.new
  item.title       = "My News Number #{i}"
  item.link        = "http://pragprog.com/pragdave/story_#{i}"
  item.description = "This is a story about number #{i}"
  chan.items << item
end

puts rss.to_s
