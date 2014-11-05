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
require 'date'
include Globalize

files = Dir.glob("D:/projects/temp/old-mlr/lib/globalize/locales/country-data/*.rb")
files.each do |fp|
  sections = fp.split '/'
  fn = sections.last
  code, ext = fn.split '.'
  code.upcase!

  country = Country.pick(code)

  if !country
    puts "ERROR: can't find #{code}"
    next
  end


  str = File.read(fp)
  eval str

  country.thousands_sep = @country_data[:mon_thousands_sep]
  country.decimal_sep = @country_data[:mon_decimal_point]

  country.save!

  puts "updated #{country.english_name}"
  
end

