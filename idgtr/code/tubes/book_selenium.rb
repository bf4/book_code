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

class BookSearch
  def initialize
    @browser = Selenium::SeleniumDriver.new \
      'localhost', 4444, '*firefox', 'http://www.pragprog.com', 10000
    @browser.start
  end

  def close
    @browser.stop
  end
end


class BookSearch
  ResultCounter = '//table[@id="bookshelf"]//tr'  #(1)
  ResultReader = 'xpath=/descendant::td[@class="description"]'

  def find(term)
    @browser.open '/'
    @browser.window_maximize
    @browser.type  '//input[@id="q"]', term
    @browser.click '//button[@class="go"]'
    @browser.wait_for_page_to_load 5000
    num_results = @browser.get_xpath_count(ResultCounter).to_i
	
    (1..num_results).inject({}) do |results, i|
      full_title = @browser.get_text("#{ResultReader}[#{i}]/h4/a") #(2)
      byline = @browser.get_text("#{ResultReader}[#{i}]/p[@class='by-line']")
      url = @browser.get_attribute("#{ResultReader}[#{i}]/h4/a@href")
      title, subtitle = full_title.split ': '
      authors = authors_from byline #(3)
      results.merge title =>
      {
        :title => title,
        :subtitle => subtitle,
        :url => url,
        :authors => authors
      }
    end
  end
end


class BookSearch
  def authors_from(byline)
    byline[3..-1].gsub(/(,? and )|(,? with )/, ',').split(',')
  end
end
