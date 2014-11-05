#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.column :name, :string
    end
    
    ['Mexican', 'Italian', 'Japanese', 'Chinese', 
     'Korean', 'Sandwiches', 'Indian', 'BBQ', 'American'].each do |c| 
      Category.create :name => c
    end
  end

  def self.down
    drop_table :categories
  end
end
