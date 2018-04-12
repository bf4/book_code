#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class CreatePerformances < ActiveRecord::Migration[5.0]

  def change
    create_table :performances do |t|
      t.references :event, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end

end
