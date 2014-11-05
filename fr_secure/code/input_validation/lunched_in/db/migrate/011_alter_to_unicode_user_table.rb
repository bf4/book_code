#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
class AlterToUnicodeUserTable < ActiveRecord::Migration
  def self.up
      execute "ALTER TABLE users MODIFY first_name VARCHAR(255) CHARACTER SET utf8;"
      execute "ALTER TABLE users MODIFY first_name VARCHAR(255) CHARACTER SET utf8;"
  end

  def self.down
  end
end
