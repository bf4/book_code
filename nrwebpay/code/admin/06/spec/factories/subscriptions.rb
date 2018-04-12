#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
FactoryGirl.define do
  factory :subscription do
    user nil
    plan nil
    start_date "2016-07-30"
    end_date "2016-07-30"
    status 1
    payment_method "MyString"
    remote_id "MyString"
    string "MyString"
  end
end
