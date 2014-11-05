#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'rubygems'
require 'dbi'

DBI.connect('DBI:Jdbc:mysql://localhost/using_jruby', 
            'root', 
            '',
            'driver'=>'com.mysql.jdbc.Driver') do |dbh|
  dbh.do("DROP TABLE IF EXISTS blogs")

  dbh.do(<<SQL)
CREATE TABLE blogs(
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(255),
  author VARCHAR(255),
  PRIMARY KEY (id))
SQL
  
  dbh.do(<<SQL)
INSERT INTO blogs (name, author)
 VALUES
  ('Languages', 'Ola Bini'),
  ('Politics', 'Roy Singham'),
  ('Environment', 'Al Gore')
SQL
end
