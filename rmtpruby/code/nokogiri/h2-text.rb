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
  <h2>This is a heading</h2>
  <p>This is a paragraph</p>

  <h2>This is also a heading</h2>
  <p>This is also a paragraph</p>
</body>
</html>
DOC

doc.css("h2").each do |heading|
  heading.text
  # => "This is a heading"
  #    , "This is also a heading"
end

