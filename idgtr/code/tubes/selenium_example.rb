#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
require 'rubygems'
require 'selenium'

browser = Selenium::SeleniumDriver.new \
  'localhost', 4444, '*firefox', 'http://www.pragprog.com', 10000 #(1)

browser.start
browser.open 'http://www.pragprog.com'


browser.type  '//input[@id="q"]', 'Ruby' #(2)
browser.click '//button[@class="go"]'    #(3)
browser.wait_for_page_to_load 5000


num_results = browser.get_xpath_count('//table[@id="bookshelf"]//tr').to_i


results = (1..num_results).map do |n|
  element  = "xpath=/descendant::td[@class='description'][#{n}]/h4/a" #(4)
  title    = browser.get_text(element)
  url      = browser.get_attribute(element + '@href') #(5)

  {:title => title, :url => url, :element => element}
end

results.each do |r|
  puts 'Title: ' + r[:title]
  puts 'Link:  ' + r[:url]
  puts
end


pickaxe = results.find {|r| r[:title].include? 'Programming Ruby 1.9'}
browser.click pickaxe[:element]
browser.wait_for_page_to_load 5000


browser.click '//button[@class="add-to-cart"]'
browser.wait_for_page_to_load 5000

browser.click '//button[@id="check-out-button"]' # redirects to https
browser.wait_for_page_to_load 5000
