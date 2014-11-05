#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
class DeviseCreateDesigners < ActiveRecord::Migration
  def self.up
    create_table(:designers) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable


      t.timestamps
    end

    add_index :designers, :email,                :unique => true
    add_index :designers, :reset_password_token, :unique => true
    # add_index :designers, :confirmation_token,   :unique => true
    # add_index :designers, :unlock_token,         :unique => true
    # add_index :designers, :authentication_token, :unique => true
  end

  def self.down
    drop_table :designers
  end
end
