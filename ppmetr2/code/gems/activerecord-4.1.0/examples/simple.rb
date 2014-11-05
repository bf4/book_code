#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require File.expand_path('../../../load_paths', __FILE__)
require 'active_record'

class Person < ActiveRecord::Base
  establish_connection adapter: 'sqlite3', database: 'foobar.db'
  connection.create_table table_name, force: true do |t|
    t.string :name
  end
end

bob = Person.create!(name: 'bob')
puts Person.all.inspect
bob.destroy
puts Person.all.inspect
