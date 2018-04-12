#---
# Excerpted from "Agile Web Development with Rails 5.1",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rails51 for more book information.
#---
require "application_system_test_case"


class OrdersTest < ApplicationSystemTestCase
  include ActiveJob::TestHelper
    

  test "check routing number" do

    LineItem.delete_all
    Order.delete_all

    visit store_index_url

    visit store_index_url

    first('.entry').click_on 'Add to Cart'

    click_on 'Checkout'

    fill_in 'order_name', with: 'Dave Thomas'
    fill_in 'order_address', with: '123 Main Street'
    fill_in 'order_email', with: 'dave@example.com'

    assert_no_selector "#order_routing_number"

    select 'Check', from: 'pay_type'


    assert_selector "#order_routing_number"

    fill_in "Routing #", with: "123456"
    fill_in "Account #", with: "987654"

    perform_enqueued_jobs do
      click_button "Place Order"
    end

    orders = Order.all
    assert_equal 1, orders.size

    order = orders.first

    assert_equal "Dave Thomas",      order.name
    assert_equal "123 Main Street",  order.address
    assert_equal "dave@example.com", order.email
    assert_equal "Check",            order.pay_type
    assert_equal 1, order.line_items.size

    mail = ActionMailer::Base.deliveries.last
    assert_equal ["dave@example.com"],                 mail.to
    assert_equal 'Sam Ruby <depot@example.com>',       mail[:from].value
    assert_equal "Pragmatic Store Order Confirmation", mail.subject

  end 
end
