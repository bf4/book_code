#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dcbang for more book information.
#---
class AddLowerIndexesToCustomers < ActiveRecord::Migration
  def up
    execute %{
      CREATE INDEX 
        customers_lower_last_name 
      ON 
        customers (lower(last_name))
    }
    execute %{
      CREATE INDEX 
        customers_lower_first_name
      ON 
        customers (lower(first_name))
    }
    execute %{
      CREATE INDEX 
        customers_lower_email 
      ON 
        customers (lower(email))
    }
  end
  def down
    remove_index 'customers_lower_last_name'
    remove_index 'customers_lower_first_name'
    remove_index 'customers_lower_email'
  end
end
