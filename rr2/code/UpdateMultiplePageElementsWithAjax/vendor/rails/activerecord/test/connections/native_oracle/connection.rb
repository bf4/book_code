#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
print "Using Oracle\n"
require_dependency 'fixtures/course'
require 'logger'

ActiveRecord::Base.logger = Logger.new STDOUT
ActiveRecord::Base.logger.level = Logger::WARN

# Set these to your database connection strings
db = ENV['ARUNIT_DB'] || 'activerecord_unittest'

ActiveRecord::Base.establish_connection(
  :adapter  => 'oracle',
  :username => 'arunit',
  :password => 'arunit',
  :database => db
)

Course.establish_connection(
  :adapter  => 'oracle',
  :username => 'arunit2',
  :password => 'arunit2',
  :database => db
)
