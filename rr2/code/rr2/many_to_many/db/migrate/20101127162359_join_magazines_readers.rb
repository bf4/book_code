#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class JoinMagazinesReaders < ActiveRecord::Migration
  def self.up
    create_table :magazines_readers, :id => false do |t|
      t.integer :magazine_id
      t.integer :reader_id
    end
  end

  def self.down
    drop_table :magazines_readers
  end
end
