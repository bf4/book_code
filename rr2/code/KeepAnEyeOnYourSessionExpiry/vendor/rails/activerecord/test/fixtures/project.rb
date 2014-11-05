#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class Project < ActiveRecord::Base
  has_and_belongs_to_many :developers, :uniq => true
  has_and_belongs_to_many :limited_developers, :class_name => "Developer", :limit => 1
  has_and_belongs_to_many :developers_named_david, :class_name => "Developer", :conditions => "name = 'David'", :uniq => true
  has_and_belongs_to_many :salaried_developers, :class_name => "Developer", :conditions => "salary > 0"
  has_and_belongs_to_many :developers_with_finder_sql, :class_name => "Developer", :finder_sql => 'SELECT t.*, j.* FROM developers_projects j, developers t WHERE t.id = j.developer_id AND j.project_id = #{id}'
  has_and_belongs_to_many :developers_by_sql, :class_name => "Developer", :delete_sql => "DELETE FROM developers_projects WHERE project_id = \#{id} AND developer_id = \#{record.id}"
  has_and_belongs_to_many :developers_with_callbacks, :class_name => "Developer", :before_add => Proc.new {|o, r| o.developers_log << "before_adding#{r.id}"},
                            :after_add => Proc.new {|o, r| o.developers_log << "after_adding#{r.id}"}, 
                            :before_remove => Proc.new {|o, r| o.developers_log << "before_removing#{r.id}"},
                            :after_remove => Proc.new {|o, r| o.developers_log << "after_removing#{r.id}"}

  attr_accessor :developers_log

  def after_initialize
    @developers_log = []
  end

end

class SpecialProject < Project
  def hello_world
    "hello there!"
  end
end
