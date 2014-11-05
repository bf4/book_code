#---
# Excerpted from "Programming Ruby 1.9 and 2.0",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ruby4 for more book information.
#---
require 'fiddle'

user32  = DL.dlopen("user32.dll")
msgbox  = Fiddle::Function.new(user32['MessageBoxA'],
                               [TYPE_LONG, TYPE_VOIDP, TYPE_VOIDP, TYPE_INT],
                               TYPE_INT)
MB_OKCANCEL = 1
msgbox.call(0, "OK?", "Please Confirm", MB_OKCANCEL)
