#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
FactoryGirl.define do
  factory :plan do
    remote_id "MyString"
    name "MyString"
    price_cents 10_000
    interval 2
    interval_count 1
    tickets_allowed 1
    ticket_category "MyString"
    status 1
    description "MyText"
  end
end
