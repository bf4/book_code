#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
html = <<HTML
<!DOCTYPE html>
<html>
  <head>
    <title>A sample document</title>
  </head>
  <body>
    <h1>A sample document
  </body>
</html>
HTML

doc = Nokogiri::HTML(html)

