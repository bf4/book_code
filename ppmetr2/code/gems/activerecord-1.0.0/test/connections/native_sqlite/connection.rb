#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
print "Using native SQlite\n"
require 'fixtures/course'
require 'logger'
ActiveRecord::Base.logger = Logger.new("debug.log")

base = "#{File.dirname(__FILE__)}/../../fixtures"
sqlite_test_db  = "#{base}/fixture_database.sqlite"
sqlite_test_db2 = "#{base}/fixture_database_2.sqlite"

[sqlite_test_db, sqlite_test_db2].each do |db|
  unless File.exist?(db) and File.size(db) > 0
    puts "*** You must create the SQLite test database in: #{db} ***"
    exit!
  else
    puts "OK: #{db}"
  end
end

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite",
  :dbfile  => sqlite_test_db)
Course.establish_connection(
  :adapter => "sqlite",
  :dbfile  => sqlite_test_db2)
