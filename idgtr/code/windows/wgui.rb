#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
require 'win32/guitest'
require 'win32/guitest_svn' #(1)

include Win32::GuiTest

system 'start "" "C:/Windows/System32/notepad.exe"'
sleep 1

w = findWindowLike(nil, /^Untitled - Notepad$/).first
w.sendkeys 'This is some text'
w.sendkeys ctrl('a')
w.sendkeys 'And this is its replacement'

e = w.children.find {|c| c.classname == 'Edit'}
puts e.windowText #(2)

w.sendkeys alt(key('F4'))
sleep 0.5

d = findWindowLike(nil, /^Notepad$/).first
d.sendkeys 'n'
