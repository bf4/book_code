#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class ConvertToJoinModel < ActiveRecord::Migration
  def self.up
    drop_table :magazines_readers
    create_table :subscriptions do |t|
      t.column :reader_id, :integer
      t.column :magazine_id, :integer
      t.column :last_renewal_on, :date
      t.column :length_in_issues, :integer
    end
  end
  def self.down
  end
end
