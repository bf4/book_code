#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
require 'rubygems'
require 'watir'

class BookSearch
  def initialize
    @browser = Watir::IE.new
  end

  def close
    @browser.close
  end
end


class BookSearch
  def find(term)
    @browser.goto 'http://www.pragprog.com'
    @browser.text_field(:id, 'q').set('Ruby') #(1)
    @browser.button(:class, 'go').click       #(2)

    bookshelf = @browser.table(:id, 'bookshelf')
    num_results = bookshelf.row_count

    (0...num_results).inject({}) do |results, i|
      book = bookshelf[i][1] #(3)

      full_title = book.h4.text
      byline     = book.p(:class, 'by-line').text
      url        = book.link.href

      title, subtitle = full_title.split ': '
      authors = authors_from byline

      results.merge title => {
        :title => title,
        :subtitle => subtitle,
        :url => url,
        :authors => authors }
    end
  end
end


class BookSearch
  def authors_from(byline)
    byline[3..-1].gsub(/(,? and )|(,? with )/, ',').split(',')
  end
end
