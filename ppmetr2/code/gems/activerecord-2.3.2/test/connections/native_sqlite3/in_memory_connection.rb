#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
print "Using native SQLite3\n"
require_dependency 'models/course'
require 'logger'
ActiveRecord::Base.logger = Logger.new("debug.log")

class SqliteError < StandardError
end

def make_connection(clazz, db_definitions_file)
  clazz.establish_connection(:adapter => 'sqlite3', :database  => ':memory:')
  File.read(SCHEMA_ROOT + "/#{db_definitions_file}").split(';').each do |command|
    clazz.connection.execute(command) unless command.strip.empty?
  end
end

make_connection(ActiveRecord::Base, 'sqlite.sql')
make_connection(Course, 'sqlite2.sql')
load(SCHEMA_ROOT + "/schema.rb")
