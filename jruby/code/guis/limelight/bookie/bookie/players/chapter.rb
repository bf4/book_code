#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
module Chapter
  attr_accessor :model

  def mouse_clicked(e)
    scene.dual_pane.current_chapter = @model
  end

  def select!
    style.background_color = :sky_blue
  end

  def deselect!
    style.background_color = :white
  end
end
