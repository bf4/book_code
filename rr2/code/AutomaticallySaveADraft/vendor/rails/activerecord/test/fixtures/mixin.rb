#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class Mixin < ActiveRecord::Base

end

class TreeMixin < Mixin 
    acts_as_tree :foreign_key => "parent_id", :order => "id"
end

class TreeMixinWithoutOrder < Mixin
    acts_as_tree :foreign_key => "parent_id"
end

class ListMixin < Mixin
  acts_as_list :column => "pos", :scope => :parent

  def self.table_name() "mixins" end
end

class ListMixinSub1 < ListMixin
end

class ListMixinSub2 < ListMixin
end


class ListWithStringScopeMixin < ActiveRecord::Base
  acts_as_list :column => "pos", :scope => 'parent_id = #{parent_id}'

  def self.table_name() "mixins" end
end

class NestedSet < Mixin
  acts_as_nested_set :scope => "root_id IS NULL"
  
  def self.table_name() "mixins" end
end

class NestedSetWithStringScope < Mixin
  acts_as_nested_set :scope => 'root_id = #{root_id}'
  
  def self.table_name() "mixins" end
end

class NestedSetWithSymbolScope < Mixin
  acts_as_nested_set :scope => :root
  
  def self.table_name() "mixins" end
end
