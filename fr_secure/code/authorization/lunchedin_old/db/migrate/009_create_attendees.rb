#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
class CreateAttendees < ActiveRecord::Migration
  def self.up
    create_table :attendees do |t|
      t.column :name, :string, :null => false
      t.column :email, :string, :null => false
      t.column :status, :string, :null => false, :default => "no response"
      t.column :event_id, :integer
    end
  end

  def self.down
    drop_table :attendees
  end
end
