#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
print "Using native PostgreSQL\n"
require 'fixtures/course'
require 'logger'

ActiveRecord::Base.logger = Logger.new("debug.log")

db1 = 'activerecord_unittest'
db2 = 'activerecord_unittest2'

ActiveRecord::Base.establish_connection(
  :adapter  => "postgresql",
  :host     => nil, 
  :username => "postgres",
  :password => "postgres", 
  :database => db1
)

Course.establish_connection(
  :adapter  => "postgresql",
  :host     => nil, 
  :username => "postgres",
  :password => "postgres", 
  :database => db2
)