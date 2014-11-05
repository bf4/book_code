#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
require 'win32ole'

wsh = WIN32OLE.new 'Wscript.Shell'

wsh.Exec 'notepad'
sleep 1
wsh.AppActivate 'Untitled - Notepad'

wsh.SendKeys 'This is some text'

wsh.SendKeys '%EA'
wsh.SendKeys 'And this is its replacement'
wsh.SendKeys '%{F4}'

if wsh.AppActivate 'Notepad'
  wsh.SendKeys 'n'
end
