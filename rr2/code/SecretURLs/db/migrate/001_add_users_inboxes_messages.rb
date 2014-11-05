#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class AddUsersInboxesMessages < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :name, :string
      t.column :password, :string
    end
    create_table :inboxes do |t|
      t.column :user_id, :integer
      t.column :access_key, :string
    end
    create_table :messages do |t|                      
      t.column :inbox_id, :integer
      t.column :sender_id, :integer
      t.column :title, :string
      t.column :body, :text
      t.column :created_at, :datetime
    end
  end

  def self.down                       
    drop_table :users
    drop_table :inboxes
    drop_table :messages
  end
end
