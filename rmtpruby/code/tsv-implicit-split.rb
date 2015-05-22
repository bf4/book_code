#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
$/ = "\n"
$; = "\t"

File.open("data/shopping.tsv") do |file|
  file.each do |record|
    record.chomp.split
    # => ["White Bread", "£1.20", "Baker"]
    #    , ["Whole Milk", "£0.80", "Corner Shop"]
    #    , ["Gorgonzola", "£10.20", "Cheese Shop"]
    #    , ["Mature Cheddar", "£5.20", "Cheese Shop"]
    #    , ["Limburger", "£6.35", "Cheese Shop"]
    #    , ["Newspaper", "£1.20", "Corner Shop"]
    #    , ["Ilchester", "£3.99", "Cheese Shop"]
  end
end


