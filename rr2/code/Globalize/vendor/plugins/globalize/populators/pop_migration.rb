#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
ENV["RAILS_ENV"] = 'development'
require 'config/environment'
include Globalize

# This isn't currently being used

model = Language
items = model.find(:all)
fields = model.column_names

recs = []
items.each do |i|
  atts = i.attributes_before_type_cast
  ary = fields.map {|f| atts[f] }
  recs.push(ary.inspect)
end

puts "[\n  " + recs.join(",\n  ") + "\n]" 