#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class CreateCourseRecords < ActiveRecord::Migration
  def self.up
    create_table :course_records do |t|
      t.integer :course_id
      t.integer :student_id
      t.string :letter_grade

      t.timestamps
    end
  end

  def self.down
    drop_table :course_records
  end
end
