#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
require 'prelude'

ActiveRecord::Schema.define do
  
  create_table :orders, :force => true do |t|
    t.column :user_id, :integer
  end
  
  create_table :users, :force => :true do |t|
    t.column :name, :string
  end
end

class User < ActiveRecord::Base
  has_many :orders
end

class Order < ActiveRecord::Base
  belongs_to :user
end

ned    = User.create(:name => 'Ned')
mike   = User.create(:name => 'Mike')
nicole = User.create(:name => 'Nicole')

Order.create(:user => ned)
Order.create(:user => mike)
Order.create(:user => nicole)
Order.create(:user => ned)
Order.create(:user => mike)
Order.create(:user => nicole)
Order.create(:user => ned)

puts :unscoped
p User.find(:all)   #=> [#<User:0x77d38c @attributes={"name"=>"Ned", "id"=>"1"}>,
                    #    #<User:0x77d314 @attributes={"name"=>"Mike", "id"=>"2"}>,
                    #    #<User:0x77d2d8 @attributes={"name"=>"Nicole", "id"=>"3"}>] 

puts :scoped
User.with_scope(:find => { :conditions => "name like '%i%'"}) do
  p User.find(:all) #=> [#<User:0x5ff7b8 @attributes={"name"=>"Mike", "id"=>"2"}>, 
                    #    #<User:0x5ff2e0 @attributes={"name"=>"Nicole", "id"=>"3"}>] 
end

puts :scoped1
User.transaction do
User.with_scope(:find => { :conditions => "name like '%i%'"}) do
  p User.count       #=> 2
  User.delete_all
  p User.count       #=> 0
end
p User.count         #=> 1
  raise "rollback"
end rescue 1;

puts :indirect
User.with_scope(:find => { :conditions => "name like '%i%'"}) do
  Order.find(:all).each do |o|
    p o.user
  end
end

puts :order
begin
User.with_scope(:find => {:readonly => true}) do
  user = User.find_by_name('Ned')
  user.name = 'Walter'
  user.save!
end
rescue Exception => e
  puts e.message
end

puts :include_find
User.with_scope(:find => { :conditions => "name like '%i%'"}) do

  p User.find(:all, :conditions => "name like 'N%'")

end

puts :nest_scope
User.with_scope(:find => { :conditions => "name like '%i%'"}) do
  User.with_scope(:find => { :conditions => "name like 'N%'"}) do
    
    p User.find(:all) #=> [#<User:0x78f5dc @attributes={"name"=>"Nicole", "id"=>"3"}>] 

  end
end

puts :excl_scope
User.with_scope(:find => { :conditions => "name like '%i%'"}) do
  User.with_exclusive_scope(:find => { :conditions => "name like 'N%'"}) do
    
    p User.find(:all)  #=> [#<User:0x7876ac @attributes={"name"=>"Ned", "id"=>"1"}>,
                       #    #<User:0x787580 @attributes={"name"=>"Nicole", "id"=>"3"}>]
  end
end

