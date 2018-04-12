#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class RefundColumns < ActiveRecord::Migration[5.0]

  def change
    change_table :payments do |t|
      t.references :original_payment, index: true
      t.references :administrator, index: true
    end

    change_table :payment_line_items do |t|
      t.references :original_line_item, index: true
      t.references :administrator, index: true
      t.integer :refund_status, default: 0
    end
  end

end
