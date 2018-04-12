#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap, Second Edition",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/dcbang2 for more book information.
#---
class AddBioToCustomers < ActiveRecord::Migration[5.0]
  def up
    add_column :customers, :bio, :text
    execute %{
      CREATE INDEX
        customers_bio_index ON customers
      USING
        gin(to_tsvector('english', bio));
    }
  end
  def down
    remove_column :customers, :bio
  end
end
