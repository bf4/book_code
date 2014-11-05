#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
class AddSaltToUser < ActiveRecord::Migration
  
  def self.up
    add_column :users, :salt, :text
  end
  
  
  
  def self.down
    raise IrreversibleMigration "Salts are a one way road."
  end
  
    
  
  def self.alternate_up
    add_column :users, :salt, :text
    User.reset_column_information
    User.find(:all).each do |user|
      user.update_attribute(:salt,
        "reset_password")
    end
  end
  
end
