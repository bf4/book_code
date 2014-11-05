#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :first_name, :string
      t.column :last_name, :string
      t.column :user_name, :string, :null => false
      t.column :password, :string, :null => false
      t.column :email, :string, :null => false
      t.column :zip_code, :string
      t.column :role_id, :integer, :null => false, :default => 2
    end
  end

  def self.down
    drop_table :users
  end
end
