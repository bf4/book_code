#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.column "name", :string, :null => false
    end
    Role.create :name => 'admin'
    Role.create :name => 'user'
  end

  def self.down
    drop_table :roles
  end
end
