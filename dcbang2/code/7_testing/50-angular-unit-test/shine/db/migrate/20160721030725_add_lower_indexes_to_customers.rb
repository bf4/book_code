#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap, Second Edition",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/dcbang2 for more book information.
#---
class AddLowerIndexesToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_index :customers, "lower(last_name) varchar_pattern_ops"
    add_index :customers, "lower(first_name) varchar_pattern_ops"
    add_index :customers, "lower(email)"
  end
end
