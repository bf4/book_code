#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
require 'swing_gui'      #(1)
require 'junquenote_app'
require 'note'

class JunqueNote < Note
  include SwingGui

  @@app = JunqueNote
  @@titles[:save] = "Quittin' time"

  def initialize
    JunqueNoteApp.new
    @main_window = JFrameOperator.new 'JunqueNote'
    @edit_window = JTextAreaOperator.new @main_window #(2)
  end
end


class JunqueNote  
  def text
    @edit_window.text
  end
  def text=(message)
    @edit_window.clear_text
    @edit_window.type_text message
  end
  def close
    menu_bar = JMenuBarOperator.new @main_window
    menu_bar.push_menu_no_block 'File|Exit', '|'
  end
end
