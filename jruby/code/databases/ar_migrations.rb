#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => 'jdbc',
  :driver => 'com.mysql.jdbc.Driver',
  :url => 'jdbc:mysql://localhost/using_jruby',
  :username => 'root',
  :password => ''
)

class AddFooTable < ActiveRecord::Migration
  def self.up
    create_table :foo do |t|
      t.string  :foo
      t.text  :bar
      t.integer  :qux
    end
  end

  def self.down
    drop_table :foo
  end
end

class AddBlechColumnTable < ActiveRecord::Migration
  def self.up
    add_column :foo, :flax, :string
  end

  def self.down
    remove_column :foo, :flax
  end
end

AddFooTable.migrate(:up)
AddBlechColumnTable.migrate(:up)
AddBlechColumnTable.migrate(:down)
AddFooTable.migrate(:down)
