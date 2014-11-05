#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
module Bookie
  prop_reader :chapter_list, :dual_pane
  prop_reader :preview_pane, :edit_pane
  prop_reader :preview_tab, :edit_tab

  def scene_opened(e)
    chapter_list.repopulate
    chapter_list.select(1, true)
    dual_pane.edit!
  end
end
