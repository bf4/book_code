#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
require 'applescript'

include AppleScript

RightArrow = 124

tell.application("TextEdit").activate! #(1)
tell.application("TextEdit").make_new_document!

tell.application("System Events").
  process("TextEdit").
  menu_bar(1).
  menu_bar_item("Edit"). #(2)
  menu("Edit") do  #(3)
    keystroke! "H"
    keystroke! "i"
    click_menu_item! "Select All"
    click_menu_item! "Copy"
    key_code! RightArrow
       click_menu_item! "Paste"
  end
