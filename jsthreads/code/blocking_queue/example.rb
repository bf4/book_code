#---
# Excerpted from "Working with Ruby Threads",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsthreads for more book information.
#---
require_relative 'complete'

require 'open-uri'
require 'nokogiri'

comics = BlockingQueue.new
titles = BlockingQueue.new

10.times do
  Thread.new do
    xkcd_comic_html = open('http://dynamic.xkcd.com/random/comic').read
    comics.push(xkcd_comic_html)
  end
end

3.times do
  Thread.new do
    loop do
      comic_html = comics.pop
      title = Nokogiri::HTML(comic_html).css('#ctitle').text

      titles.push(title)
    end
  end
end

puts "Here's the titles of 10 random xkcd comics"
10.times do
  puts titles.pop
end

