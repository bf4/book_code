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
      t.string :name
      t.datetime :occurs_on, :default => nil
      t.string :status, :default => 'planning'
      t.text :notes
      t.integer :user_id, :default => nil
      t.integer :venue_id, :default => nil
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
