#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
require 'win32ole'
class UnitWorld
  # ... definitions will go here ...

  TITLE   = 'Unit Converter'
  
  def initialize
    @auto_it = WIN32OLE.new 'AutoitX3.Control'
    @auto_it.Run 'C:\Converter\Unit Converter.exe'
    @auto_it.WinWaitActive TITLE
  end
  def close
    @auto_it.WinClose TITLE
  end

  INPUT   = '[NAME:txtbxA]'
  CONVERT = '[NAME:m2k]'
  RESULT  = '[NAME:txtbxAnsA]'

  def convert_miles_to_km(miles)
    @auto_it.ControlSetText TITLE, '', INPUT, miles.to_s
    @auto_it.ControlClick   TITLE, '', CONVERT
  end
  def result
    @auto_it.ControlGetText(TITLE, '', RESULT).to_f
  end

end
World { UnitWorld.new }
After do
  close
end
