#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class CreateShoppingCarts < ActiveRecord::Migration[5.0]

  def change
    create_table :shopping_carts do |t|
      t.references :user, foreign_key: true
      t.references :address, foreign_key: true
      t.integer :shipping_method, default: 0
      t.references :discount_code, foreign_key: true

      t.timestamps
    end
  end

end
