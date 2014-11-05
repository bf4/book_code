#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
class AddAttachmentFileToAsset < ActiveRecord::Migration
  def self.up
    add_column :assets, :file_file_name, :string
    add_column :assets, :file_content_type, :string
    add_column :assets, :file_file_size, :integer
    add_column :assets, :file_updated_at, :datetime
  end

  def self.down
    remove_column :assets, :file_file_name
    remove_column :assets, :file_content_type
    remove_column :assets, :file_file_size
    remove_column :assets, :file_updated_at
  end
end
