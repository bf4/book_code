#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# Be sure to change the mysql_connection details and create a database for the example

$: << File.dirname(__FILE__) + '/../lib'

require 'active_record'
require 'logger'; class Logger; def format_message(severity, timestamp, msg, progname) "#{msg}\n" end; end

ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.establish_connection(
  :adapter  => "mysql", 
  :host     => "localhost", 
  :username => "root", 
  :password => "", 
  :database => "activerecord_examples"
)
