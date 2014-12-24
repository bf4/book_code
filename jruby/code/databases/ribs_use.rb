#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'rubygems'
require 'ribs'

Ribs::DB.define do |db|
  db.dialect = 'Derby'
  db.uri = 'jdbc:derby:using_jruby;create=true'
  db.driver = 'org.apache.derby.jdbc.EmbeddedDriver'
end

Ribs::with_handle do |h|
  h.ddl "DROP TABLE book" rescue nil

  h.ddl <<SQL
CREATE TABLE book (
  id INT NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  title VARCHAR(255) NOT NULL,
  author VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
)
SQL

  stmt = "INSERT INTO book(title, author) VALUES(?, ?)"
  h.insert(stmt,
           ["To Say Nothing Of The Dog", "Connie Willis"],
           ["A Confederacy Of Dunces", "John Kennedy Toole"],
           ["Ender's Game", "Orson Scott Card"])

  p h.select("SELECT * FROM book")
end

class Book
  attr_accessor :id, :title, :author
end

p R(Book).all

dog = R(Book).get(1)
dog.title += ": How We Found the Bishop's Bird Stump at Last"
R(dog).save

R(Book).create :id => 4,
               :title => "Goedel, Escher, Bach",
               :author => "Douglas Hofstadter"

snow = Book.new
snow.id = 5
snow.title = "Snow Crash"
snow.author = "Neal Stephenson"
R(snow).save

R(snow).destroy!

p R(Book).all