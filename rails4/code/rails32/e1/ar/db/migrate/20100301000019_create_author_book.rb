#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
class CreateAuthorBook < ActiveRecord::Migration
  def self.up
    create_table :authors_books, :id => false do |t|
      t.integer :author_id, :null => false
      t.integer :book_id,   :null => false
    end
  end

  def self.down
    drop_table :authors_books
  end
end
