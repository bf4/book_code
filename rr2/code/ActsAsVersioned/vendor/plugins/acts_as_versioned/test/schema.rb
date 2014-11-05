#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
ActiveRecord::Schema.define(:version => 0) do
  create_table :pages, :force => true do |t|
    t.column :version, :integer
    t.column :title, :string, :limit => 255
    t.column :body, :text
    t.column :updated_on, :datetime
  end

  create_table :page_versions, :force => true do |t|
    t.column :page_id, :integer
    t.column :version, :integer
    t.column :title, :string, :limit => 255
    t.column :body, :text
    t.column :updated_on, :datetime
  end
  
  create_table :locked_pages, :force => true do |t|
    t.column :lock_version, :integer
    t.column :title, :string, :limit => 255
    t.column :type, :string, :limit => 255
  end

  create_table :locked_pages_revisions, :force => true do |t|
    t.column :page_id, :integer
    t.column :version, :integer
    t.column :title, :string, :limit => 255
    t.column :version_type, :string, :limit => 255
    t.column :updated_at, :datetime
  end

  create_table :widgets, :force => true do |t|
    t.column :name, :string, :limit => 50
    t.column :version, :integer
    t.column :updated_at, :datetime
  end

  create_table :widget_versions, :force => true do |t|
    t.column :widget_id, :integer
    t.column :name, :string, :limit => 50
    t.column :version, :integer
    t.column :updated_at, :datetime
  end
end