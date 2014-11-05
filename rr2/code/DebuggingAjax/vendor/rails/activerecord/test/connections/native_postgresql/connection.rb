#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
print "Using native PostgreSQL\n"
require_dependency 'fixtures/course'
require 'logger'

ActiveRecord::Base.logger = Logger.new("debug.log")

db1 = 'activerecord_unittest'
db2 = 'activerecord_unittest2'

ActiveRecord::Base.establish_connection(
  :adapter  => "postgresql",
  :username => "postgres",
  :password => "postgres", 
  :database => db1,
  :min_messages => "warning"
)

Course.establish_connection(
  :adapter  => "postgresql",
  :username => "postgres",
  :password => "postgres", 
  :database => db2,
  :min_messages => "warning"
)
