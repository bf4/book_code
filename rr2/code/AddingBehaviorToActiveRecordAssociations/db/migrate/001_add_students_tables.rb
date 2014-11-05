#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class AddStudentsTables < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.column :name, :string
      t.column :graduating_year, :integer
    end                                  
    create_table :grades do |t|
      t.column :student_id, :integer
      t.column :score, :integer # 4-point scale
      t.column :class, :string      
    end
  end

  def self.down               
    drop_table :students
    drop_table :grades
  end
end
