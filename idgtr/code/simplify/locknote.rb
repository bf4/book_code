#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
require 'windows_gui'
require 'note'
class LockNote < Note
  include WindowsGui

  @@app = LockNote
  @@titles[:save] = 'Steganos LockNote'
  
  def initialize
    system 'start "" "C:/LockNote/LockNote.exe"'

    @main_window = Window.top_level 'LockNote - Steganos LockNote'
    @edit_window = @main_window.child 'ATL:00434310'
  end
end

class LockNote
  def text
    @edit_window.text
  end
  
  def text=(message)
    keystroke VK_CONTROL, ?A
    keystroke VK_BACK
    type_in(message)
  end
  
  def close
    @main_window.close
  end
end
