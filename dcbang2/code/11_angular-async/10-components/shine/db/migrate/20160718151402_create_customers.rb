#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap, Second Edition",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/dcbang2 for more book information.
#---
class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string :first_name , null: false
      t.string :last_name  , null: false
      t.string :email      , null: false
      t.string :username   , null: false

      t.timestamps           null: false
    end
    add_index :customers, :email, unique: true
    add_index :customers, :username, unique: true
  end
end
