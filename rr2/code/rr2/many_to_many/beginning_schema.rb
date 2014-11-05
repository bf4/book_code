#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
  create_table :magazines do |t|
    t.string   :title
    t.datetime :created_at
    t.datetime :updated_at
  end

  create_table :readers do |t|
    t.string   :name
    t.datetime :created_at
    t.datetime :updated_at
  end

  create_table :magazines_readers, :id => false do |t|
    t.integer :magazine_id
    t.integer :reader_id
  end

