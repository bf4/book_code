#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class AddDatabaseStructureForTagging < ActiveRecord::Migration
  def self.up
    create_table :taggings do |t|
      t.column :taggable_id, :integer 
      t.column :tag_id, :integer
      t.column :taggable_type, :string
     end
     create_table :tags do |t|
      t.column :name, :string
     end
  end

  def self.down
    drop_table :taggings
    drop_table :tags
  end
end
