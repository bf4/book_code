#---
# Excerpted from "Programming Ruby 1.9 and 2.0",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ruby4 for more book information.
#---

class SalesDataFeed
  
  def initialize
    @items = []
  end
  
  def add_sales_item(isbn, amount)
    @items << Book.new(isbn, amount)
  end
  
  def total_sales
    @items.inject(0.0) {|sum, item| sum + item.amount}
  end
  
  def print_plain_text_data
    @items.each do |item|
      printf("%-10s %10.2f\n", item.isbn, item.amount)
    end 
    printf("           ----------\n")                    
    printf("%21.2f\n", total_sales)
  end
end

class CsvDataFeed < SalesDataFeed
  require 'csv'
  
  def initialize(csv_file_name)
    super()
    CSV.foreach(csv_file_name, headers: true) do |row|
      add_sales_item(row["isbn"], row["Amount"])
    end
  end
end

class XmlDataFeed < SalesDataFeed
end


feed = CsvDataFeed.new("data.csv")

puts feed.total_sales

feed.print_plain_text_data