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
  :adapter => 'jdbcmysql',
  :database => 'using_jruby',
  :host => 'localhost',
  :username => 'root',
  :password => ''
)

ActiveRecord::Base.connection.execute("CREATE TABLE FOO1(id INTEGER)")
p ActiveRecord::Base.connection.execute("SHOW TABLES")
