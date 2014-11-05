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
  sth = dbh.prepare("INSERT INTO blogs (name, author) VALUES(?, ?)")

  sth.execute("Architecture", "Richard Gabriel")
  sth.execute("Physics", "Lee Smolin")
  sth.execute("Memes", "Richard Dawkins")

  sth.finish
end
