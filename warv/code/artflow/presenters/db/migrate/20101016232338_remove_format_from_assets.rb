#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
class RemoveFormatFromAssets < ActiveRecord::Migration
  def self.up
    remove_column :assets, :format
  end

  def self.down
    add_column :assets, :format, :string
  end
end
