#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
require "nokogiri"

doc = Nokogiri::HTML(<<-DOC)
<html>
<body>
  <ul><li>List item one</li><li>List item two</li></ul>
</body>
</html>
DOC

first_li = doc.at_css("li")

second_li = first_li.next_sibling
second_li.text
# => "List item two"

first_li = second_li.previous_sibling
first_li.text
# => "List item one"

