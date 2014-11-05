#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# Create a new database each time
File.delete 'dbfile' if File.exist? 'dbfile'

require 'active_record'
ActiveRecord::Base.establish_connection :adapter => "sqlite3",
                                        :database => "dbfile" 

# Initialize the database schema
ActiveRecord::Base.connection.create_table :ducks do |t|
  t.string  :name
end

class Duck < ActiveRecord::Base
  validate do
    errors.add(:base, "Illegal duck name.") unless name[0] == 'D'
  end
end

my_duck = Duck.new
my_duck.name = "Donald"
my_duck.valid?         # => true
my_duck.save!

require_relative '../test/assertions'
assert my_duck.valid?

bad_duck = Duck.new(:name => "Ronald")
assert !bad_duck.valid?

duck_from_database = Duck.first
duck_from_database.name         # => "Donald"

assert_equals "Donald", duck_from_database.name

duck_from_database.delete

File.delete 'dbfile' if File.exist? 'dbfile'
