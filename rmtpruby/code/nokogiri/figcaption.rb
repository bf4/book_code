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
  <figure>
    <img src="example.jpg"><figcaption>This image has a caption</figcaption>
  </figure>

  <figure>
    <img src="example-2.jpg">
  </figure>
</body>
</html>
DOC

Image = Struct.new(:file, :caption)

doc.css("img").each do |img|
  file = img["src"]

  caption = if img.next_sibling.name == "figcaption"
              img.next_sibling.text
            else
              "No caption"
            end

  Image.new(file, caption)
  # => #<struct Image file="example.jpg", caption="This image has a caption">
  #    , #<struct Image file="example-2.jpg", caption="No caption">
end
