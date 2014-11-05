#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class AddAuditTrailsTable < ActiveRecord::Migration
  def self.up
    create_table :audit_trails do |t|
      t.column :record_id, :integer
      t.column :record_type, :string
      t.column :event, :string
      t.column :user_id, :integer
      t.column :created_at, :datetime
    end
  end

  def self.down
    drop_table :audit_trails
  end
end
