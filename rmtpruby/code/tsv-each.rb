#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
File.open("data/shopping.tsv") do |file|
  file.each_line do |record|
    record
    # => "White Bread\t£1.20\tBaker\n"
    #    , "Whole Milk\t£0.80\tCorner Shop\n"
    #    , "Gorgonzola\t£10.20\tCheese Shop\n"
    #    , "Mature Cheddar\t£5.20\tCheese Shop\n"
    #    , "Limburger\t£6.35\tCheese Shop\n"
    #    , "Newspaper\t£1.20\tCorner Shop\n"
    #    , "Ilchester\t£3.99\tCheese Shop\n"
  end
end
