#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap, Second Edition",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/dcbang2 for more book information.
#---
class AddAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :states do |t|
      t.string     :code, size: 2, null: false
      t.string     :name,          null: false
    end
    create_table :addresses do |t|
      t.string     :street,        null: false
      t.string     :city,          null: false
      t.references :state,         null: false
      t.string     :zipcode,       null: false
    end
    create_table :customers_billing_addresses do |t|
      t.references :customer,      null: false
      t.references :address,       null: false
    end
    create_table :customers_shipping_addresses do |t|
      t.references :customer,      null: false
      t.references :address,       null: false
      t.boolean    :primary,       null: false, default: false
    end
  end
end
