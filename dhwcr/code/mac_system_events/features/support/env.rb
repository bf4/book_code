#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
require 'appscript'

include Appscript
module DrivesApp
  # helper methods go here...

  def click_menu(bar, item)
    app('System Events').
      processes['Hex Fiend'].
      menu_bars[1].
      menu_bar_items[bar].
      menus[bar].
      menu_items[item].
      click
  end

  def type_in(text)
    text.chars.each do |c|
      app('System Events').
        keystroke c
    end
  end

  def readout_value
    app('System Events').
      processes['Hex Fiend'].
      windows[0].
      splitter_groups[0].
      scroll_areas[0].
      tables[0].
      rows[0].
      text_fields[0].value.get
  end
end

World(DrivesApp)

`open -a 'Hex Fiend'`
at_exit { app('Hex Fiend').quit :saving => :no }
