#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
		  t.column :name, :string
			t.column :description, :text
    end
  end

  def self.down
    drop_table :images
  end
end
