#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
print "Using native DB2\n"
require_dependency 'fixtures/course'
require 'logger'

ActiveRecord::Base.logger = Logger.new("debug.log")

db1 = 'arunit'
db2 = 'arunit2'

ActiveRecord::Base.establish_connection(
  :adapter  => "db2",
  :host     => "localhost",
  :username => "arunit",
  :password => "arunit",
  :database => db1
)

Course.establish_connection(
  :adapter  => "db2",
  :host     => "localhost",
  :username => "arunit2",
  :password => "arunit2",
  :database => db2
)
