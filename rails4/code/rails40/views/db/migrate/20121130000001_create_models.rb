#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.string :input
      t.text :address
      t.string :color
      t.boolean :ketchup
      t.boolean :mustard
      t.boolean :mayonnaise
      t.date :start
      t.time :alarm

      t.timestamps
    end
  end
end
