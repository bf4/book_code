#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class CreateChapters < ActiveRecord::Migration
  def self.up
    create_table :chapters do |t|
      t.string :title
      t.text :body
      t.integer :version
      t.integer :book_id
      t.timestamps
    end
    Chapter.create_versioned_table
  end
  def self.down
    drop_table :chapters
    Chapter.drop_versioned_table
  end
end
