#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
print "Using Postgrsql via JRuby, activerecord-jdbc-adapter and activerecord-postgresql-adapter\n"
require_dependency 'models/course'
require 'logger'

ActiveRecord::Base.logger = Logger.new("debug.log")

# createuser rails --createdb --no-superuser --no-createrole
# createdb -O rails activerecord_unittest
# createdb -O rails activerecord_unittest2

ActiveRecord::Base.configurations = {
  'arunit' => {
    :adapter  => 'jdbcpostgresql',
    :username => ENV['USER'] || 'rails',
    :database => 'activerecord_unittest'
  },
  'arunit2' => {
    :adapter  => 'jdbcpostgresql',
    :username => ENV['USER'] || 'rails',
    :database => 'activerecord_unittest2'
  }
}

ActiveRecord::Base.establish_connection 'arunit'
Course.establish_connection 'arunit2'

