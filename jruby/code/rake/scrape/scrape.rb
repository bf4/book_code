#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'rubygems'
require 'open-uri'
require 'hpricot'

doc = open('http://pragprog.com/categories/upcoming') do |page|
  Hpricot page
end

(doc/'div.book').each do |book|
  title = book.at('div.details/h4').inner_html
  href  = book.at('div.thumbnail/a')['href']

  puts "#{title} is at #{href}"
end
