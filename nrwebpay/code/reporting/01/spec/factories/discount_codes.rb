#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
FactoryGirl.define do
  factory :discount_code do
    code "MyString"
    percentage 1
    description "MyText"
    minimum_amount nil
    maximum_discount nil
    max_uses 1
  end
end
