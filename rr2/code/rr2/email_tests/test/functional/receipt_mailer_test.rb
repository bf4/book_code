#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'test_helper'

class ReceiptMailerTest < ActionMailer::TestCase
  test "only sends receipts to customers who opt in for notifications" do
    customer = Customer.create!(:email_opt_in => false)
    order = customer.orders.create!(:product => products(:rails_studio_ticket))
    assert_no_emails do
      ReceiptMailer.send_receipt_if_opted_in(order)
    end

    order.customer.update_attribute(:email_opt_in, true)
    assert_emails 1 do
      ReceiptMailer.send_receipt_if_opted_in(order)
    end

  end

end
