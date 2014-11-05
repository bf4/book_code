#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class AddCategoryIdToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :category_id, :integer
  end

  def self.down
    remove_column :products, :category_id
  end
end
