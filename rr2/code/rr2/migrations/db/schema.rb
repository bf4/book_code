#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
ActiveRecord::Schema.define(:version => 20110115192759) do
  create_table "ingredients", :force => true do |t|
    t.integer "recipe_id",           :limit => 11
    t.string  "name"
    t.integer "quantity",            :limit => 11
    t.string  "unit_of_measurement"
  end

  create_table "ratings", :force => true do |t|
    t.integer "recipe_id", :limit => 11
    t.integer "user_id",   :limit => 11
    t.integer "rating",    :limit => 11
  end

  create_table "recipes", :force => true do |t|
    t.string  "name"
    t.integer "spice_level",  :limit => 11
    t.string  "region"
    t.text    "instructions"
  end

end
