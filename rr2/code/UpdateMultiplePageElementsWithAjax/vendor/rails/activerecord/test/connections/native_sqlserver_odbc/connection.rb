#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
print "Using native SQLServer via ODBC\n"
require_dependency 'fixtures/course'
require 'logger'

ActiveRecord::Base.logger = Logger.new("debug.log")

dsn1 = 'activerecord_unittest'
dsn2 = 'activerecord_unittest2'

ActiveRecord::Base.establish_connection(
  :adapter  => "sqlserver",
  :mode     => "ODBC",
  :host     => "localhost",
  :username => "sa",
  :password => "",
  :dsn => dsn1
)

Course.establish_connection(
  :adapter  => "sqlserver",
  :mode     => "ODBC",
  :host     => "localhost",
  :username => "sa",
  :password => "",
  :dsn => dsn2
)
