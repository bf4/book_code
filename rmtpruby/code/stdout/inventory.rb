#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
inventory = { "Nuts" => 124, "Bolts" => 2891, "Hammers" => 79, "Nails" => 40 }

longest = inventory.max_by { |product, items| product.length }
width   = longest.first.length

inventory.each do |product, items|
  printf "%-*s %4d\n", width, product, items
end

