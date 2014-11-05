#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.column :status, :string, :default => 'planning'
      t.column :location, :string, :default => nil
      t.column :notes, :text, :default => nil
      t.column :user_id, :integer, :default => nil
      t.column :venue_id, :integer, :default => nil
      t.column :occurs_on, :datetime, :default => nil
    end
  end

  def self.down
    drop_table :events
  end
end
