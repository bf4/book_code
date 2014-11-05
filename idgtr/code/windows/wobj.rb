#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
require 'wet-winobj'
require 'winobjects/WinLabel'
require 'winobjects/WinCheckbox'
require 'winobjects/WinRadio'

include Wet::WinUtils
include Wet::Winobjects

system 'start "" "C:/Windows/System32/notepad.exe"'
sleep 1

w = app_window 'title' => 'Untitled - Notepad'

e = w.child_objects.first
e.set 'This is some text'
e.set 'And this is its replacement'
puts e.text
