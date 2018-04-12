#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class CreateAffiliates < ActiveRecord::Migration[5.0]

  def change
    create_table :affiliates do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.string :country
      t.string :stripe_id
      t.string :tag
      t.json :verification_needed
      t.timestamps
    end

    change_table :payments do |t|
      t.references :affiliate, foreign_key: true
      t.integer :affiliate_payment_cents, default: 0, null: false
      t.string  :affiliate_payment_currency, default: "USD", null: false
    end

    change_table :shopping_carts do |t|
      t.references :affiliate
    end
  end

end
