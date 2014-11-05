#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
require 'locknote'

EditControl = LockNote::EditControl

Note.open.instance_eval do
  menu 'Edit', 'Select All'
  type_in 'asggzwhcbgk'
  keystroke 17, 90; sleep 0.5
  @main_window.click EditControl, :left, [370, 253]
  @main_window.click EditControl, :left, [370, 253]
  @main_window.click EditControl, :left, [644, 255]
  # ...
end
