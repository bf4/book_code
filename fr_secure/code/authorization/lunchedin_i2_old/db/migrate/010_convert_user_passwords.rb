#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
class ConvertUserPasswords < ActiveRecord::Migration
  def self.up
    add_column :users, :salt, :text
    users = User.find_all
    users.each do |user|
      user.update_attribute(:salt, Base64.encode64(OpenSSL::Random.random_bytes(256)))
    end
  end

  def self.down
    raise IrreversibleMigration "Cannot undo the password migration.  Sorry."
  end
end
