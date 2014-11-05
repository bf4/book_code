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

ActiveRecord::Base.logger = Logger.new(STDERR)

ActiveRecord::Schema.define do

  create_table :people, :force => true do |t|
    t.string :type

    # common attributes
    t.string :name
    t.string :email

    # attributes for type=Customer
    t.decimal :balance, :precision => 10, :scale => 2

    # attributes for type=Employee
    t.integer :reports_to
    t.integer :dept

    # attributes for type=Manager
    # -- none -- 
  end
  
end

class Person < ActiveRecord::Base
end

class Customer < Person
end

class Employee < Person
  belongs_to :boss, :class_name => "Manager", :foreign_key => :reports_to
end

class Manager < Employee
end

Customer.create(:name => 'John Doe',    :email => "john@doe.com",    
                :balance => 78.29)
                
wilma = Manager.create(:name  => 'Wilma Flint', :email => "wilma@here.com",  
                       :dept => 23)
               
Customer.create(:name => 'Bert Public', :email => "b@public.net",    
                :balance => 12.45)
                
barney = Employee.new(:name => 'Barney Rub',  :email => "barney@here.com", 
                      :dept => 23)
barney.boss = wilma
barney.save!

manager = Person.find_by_name("Wilma Flint")
puts manager.class    #=> Manager
puts manager.email    #=> wilma@here.com
puts manager.dept     #=> 23

customer = Person.find_by_name("Bert Public")
puts customer.class    #=> Customer
puts customer.email    #=> b@public.net
puts customer.balance  #=> 12.45

b = Person.find_by_name("Barney Rub")
p b.boss
