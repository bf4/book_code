#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class AddUsersInboxesMigrations < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :password
    end
    create_table :inboxes do |t|
      t.integer :user_id
      t.string :access_key
    end
    create_table :messages do |t|                      
      t.integer :inbox_id
      t.integer :sender_id
      t.string :title
      t.text :body
      t.datetime :created_at
    end
  end

  def self.down                       
    drop_table :users
    drop_table :inboxes
    drop_table :messages
  end
end
