#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
$: << File.dirname(__FILE__)
require "connect"

require "logger"
require "rubygems"
require "active_record"

require "./vendor/plugins/acts_as_list/init"

#ActiveRecord::Base.logger = Logger.new(STDERR)

ActiveRecord::Base.connection.instance_eval do
  
  create_table :parents, :force => true do |t|
  end
  
  create_table :children, :force => true do |t|
    t.integer :parent_id
    t.string  :name
    t.integer :position
  end
end


class Parent < ActiveRecord::Base
  has_many :children, :order => :position
end

class Child < ActiveRecord::Base
  belongs_to :parent
  acts_as_list  :scope => :parent
end


parent = Parent.create
%w{ One Two Three Four}.each do |name|
  parent.children.create(:name => name)
end
parent.save

def display_children(parent)
  puts parent.children(true).map {|child| child.name }.join(", ")
end

display_children(parent)         #=> One, Two, Three, Four

puts parent.children[0].first?   #=> true

two = parent.children[1]
puts two.lower_item.name         #=> Three
puts two.higher_item.name        #=> One

parent.children[0].move_lower
display_children(parent)         #=> Two, One, Three, Four

parent.children[2].move_to_top
display_children(parent)         #=> Three, Two, One, Four

parent.children[2].destroy
display_children(parent)         #=> Three, Two, Four
