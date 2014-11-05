#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class InnocentJointable < ActiveRecord::Migration
  def self.up
    create_table("people_reminders", :id => false) do |t|
      t.column :reminder_id, :integer
      t.column :person_id, :integer
    end
  end

  def self.down
    drop_table "people_reminders"
  end
end