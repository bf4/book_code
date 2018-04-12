#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap, Second Edition",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/dcbang2 for more book information.
#---
class AddStatusToCustomer < ActiveRecord::Migration[5.0]
  def up
    execute %{ CREATE TYPE
               customer_status
               AS ENUM
               ('signed_up', 'verified', 'inactive' )
    }
    add_column :customers, :status, "customer_status",
               default: "signed_up", null: false
  end
  def down
    remove_column :customers, :status
    execute %{
      DROP TYPE customer_status
    }
  end
end
