#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
# Use this migration to create the tables for the ActiveRecord store
class AddOpenIdStoreToDb < ActiveRecord::Migration
  def self.up
    create_table "open_id_associations", :force => true do |t|
      t.column "server_url", :binary, :null => false
      t.column "handle", :string, :null => false
      t.column "secret", :binary, :null => false
      t.column "issued", :integer, :null => false
      t.column "lifetime", :integer, :null => false
      t.column "assoc_type", :string, :null => false
    end

    create_table "open_id_nonces", :force => true do |t|
      t.column :server_url, :string, :null => false
      t.column :timestamp, :integer, :null => false
      t.column :salt, :string, :null => false
    end
  end

  def self.down
    drop_table "open_id_associations"
    drop_table "open_id_nonces"
  end
end
