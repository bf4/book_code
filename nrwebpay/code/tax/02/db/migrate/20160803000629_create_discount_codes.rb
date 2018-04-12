#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class CreateDiscountCodes < ActiveRecord::Migration[5.0]

  def change
    create_table :discount_codes do |t|
      t.string :code
      t.integer :percentage
      t.text :description
      t.monetize :minimum_amount
      t.monetize :maximum_discount
      t.integer :max_uses

      t.timestamps
    end

    change_table :payments do |t|
      t.references :discount_code
      t.monetize :discount
    end
  end

end
