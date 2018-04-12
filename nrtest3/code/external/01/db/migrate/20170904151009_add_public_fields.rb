#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
class AddPublicFields < ActiveRecord::Migration[5.1]
  def change
    change_table :projects do |t|
      t.boolean :public, default: false
    end

    change_table :users do |t|
      t.boolean :admin, default: false
    end
  end
end
