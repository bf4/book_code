#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Paragraph
  def initialize(text)
    @text = text
  end
  
  def title?; @text.upcase == @text; end
  def reverse; @text.reverse; end
  def upcase; @text.upcase; end
  # ...
end

def preview_formatted(paragraph); end
def preview_centered(paragraph); end

def index(paragraph)
  add_to_index(paragraph) if paragraph.title?
end

paragraph = "any string can be a paragraph"

def paragraph.title?
  self.upcase == self
end

index(paragraph)
