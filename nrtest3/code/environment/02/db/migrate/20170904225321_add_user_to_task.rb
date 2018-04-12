#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
class AddUserToTask < ActiveRecord::Migration[5.1]
  def change
    change_table :tasks do |t|
      t.references :user
    end

    change_table :users do |t|
      t.string :twitter_handle
    end
  end
end
