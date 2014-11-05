#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.string :title
      t.date :starts_on
      t.date :expires_on

      t.timestamps
    end
  end
end
