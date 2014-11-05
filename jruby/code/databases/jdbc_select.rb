#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'java'

java_import java.sql.DriverManager

DriverManager.register_driver(com.mysql.jdbc.Driver.new)

begin
  url = "jdbc:mysql://localhost/using_jruby"
  conn = DriverManager.get_connection(url, "root", "")
  stmt = conn.create_statement
  rs = stmt.execute_query("SELECT * FROM book")

  while rs.next
    p [rs.get_int(1), rs.get_string(2), rs.get_string(3)]
  end

ensure
  rs.close rescue nil
  stmt.close rescue nil
  conn.close rescue nil
end

