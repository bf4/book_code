#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
FactoryGirl.define do
  factory :address do
    address_1 "1060 W. Addison"
    address_2 ""
    city "Chicago"
    state "IL"
    zip "60613"
  end
end
