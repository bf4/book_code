#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
class BookieModel
  attr_reader   :chapters
  attr_accessor :text, :index

  def initialize
    @chapters = ['']
    @text = ''
    @index = 0
  end

  def add_chapter
    @chapters << ''
    switch_to_chapter @chapters.size - 1
  end

  def switch_to_chapter(new_index)
    @chapters[@index], @text = @text, @chapters[new_index]
    @index = new_index
  end
end
