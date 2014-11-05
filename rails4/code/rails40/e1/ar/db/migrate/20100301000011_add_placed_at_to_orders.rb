#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
class AddPlacedAtToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :placed_at, :datetime, :default => Time.now
  end

  def self.down
    remove_column :orders, :placed_at
  end
end
