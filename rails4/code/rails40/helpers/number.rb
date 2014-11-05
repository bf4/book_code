#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
require 'active_support/all'
require 'action_view'
include ActionView::Helpers::NumberHelper
number_to_currency(123.45)
number_to_currency(234.56, :unit => "CAN$", :precision => 0)
number_to_human_size(123_456)
number_to_percentage(66.66666)
number_to_percentage(66.66666, :precision => 1)
number_to_phone(2125551212)
number_to_phone(2125551212, :area_code => true, :delimiter => " ")
number_with_delimiter(12345678)
number_with_delimiter(12345678, :delimiter => "_")
number_with_precision(50.0/3, :precision => 2)
