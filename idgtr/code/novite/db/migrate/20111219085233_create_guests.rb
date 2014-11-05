#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.integer :party_id
      t.string :name
      t.boolean :attending

      t.timestamps
    end
  end
end
