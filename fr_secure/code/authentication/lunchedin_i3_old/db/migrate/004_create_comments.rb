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
      t.column :subject, :string
      t.column :body, :text
      t.column :created_on, :datetime, :default => nil
      t.column :commentable_id, :integer, :default => nil
      t.column :commentable_type, :string, :default => nil
      t.column :user_id, :integer, :default => nil
    end
  end

  def self.down
    drop_table :comments
  end
end
