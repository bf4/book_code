#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :subject
      t.text :body
      t.integer :commentable_id
      t.string :commentable_type
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
