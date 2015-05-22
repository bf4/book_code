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
  <ul><li>List item one</li>
    <li>List item two</li></ul>
</body>
</html>
DOC

list = doc.at_css("ul")

list_item = list.children.first
list_item.name
# => "li"

list_item.parent.name
# => "ul"
