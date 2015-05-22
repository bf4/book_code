#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
File.open("data/shopping.tsv") do |file|
  cheese_total = file.each_line
    .map         { |line| line.chomp.split("\t") }
    .select      { |_, _, shop| shop == "Cheese Shop" }
    .map         { |_, price, _| price }
    .reduce(0.0) { |total, price| total + price[1..-1].to_f }
    .round(2)

  puts "£#{cheese_total}"
end
# >> £25.74
