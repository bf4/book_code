#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
class CreateOpenidAssociations < ActiveRecord::Migration
  def self.up
    create_table :openid_associations do |t|
      t.column :server_url, :binary, :null => false
      t.column :handle, :string, :null => false
      t.column :secret, :binary, :null => false
      t.column :issued, :integer, :null => false
      t.column :lifetime, :integer, :null => false
      t.column :assoc_type, :string, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :openid_associations
  end
end
