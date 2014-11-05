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

class JokeList
  def initialize
    @browser = Selenium::SeleniumDriver.new \
      'localhost', 4444, '*firefox', "http://localhost:8000", 10000

    @browser.start
    @browser.open 'http://localhost:8000/dragdrop.html'
  end
  
  def close
    @browser.stop
  end
end


class JokeList
  Reorder = '//a[@id="reorder"]'
  Draggable = 'selenium.browserbot.findElement("css=.drag").visible()' #(1)
  Locked = '!' + Draggable

  def move(from_order, to_order)
    from_element = "//li[#{from_order}]/span[@class='drag']"
    to_element   = "//li[#{to_order}]/span[@class='drag']"

    @browser.click Reorder
    @browser.wait_for_condition Draggable, 2000 #(2)

    @browser.drag_and_drop_to_object from_element, to_element

    @browser.click Reorder
    @browser.wait_for_condition Locked, 2000    #(3)
  end
end


class JokeList
  def order(item)
    @browser.get_element_index(item).to_i + 1
  end
end
  

class JokeList
  def items
    num_items = @browser.get_xpath_count('//li').to_i
    (1..num_items).map {|i| @browser.get_text "//li[#{i}]/span[2]"}
  end
end
