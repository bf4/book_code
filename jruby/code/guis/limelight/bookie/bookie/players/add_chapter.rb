#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
module AddChapter
  def mouse_clicked(e)
    contents    = production.chapter_contents
    title       = (contents.length + 1).to_s
    new_content = {:title => title, :text => ''}
    contents << new_content

    scene.chapter_list.repopulate
  end
end
