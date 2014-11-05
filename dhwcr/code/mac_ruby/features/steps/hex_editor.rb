#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
require 'axelements'
require 'rspec-expectations'

class HexEditor < Spinach::FeatureSteps
  Given 'a hex editor' do
    @app = AX::Application.new 'Hex Fiend'
  end

  When 'I type some text' do
    type 'ABCD', @app
  end

  Then 'I should be able to view the bytes as an integer' do
    edit_menu       = @app.menu_bar_item title:'Edit'
    select_all_item = edit_menu.menu_item title:'Select All'
    press select_all_item

    readout = @app.main_window.table.text_field
    readout.value.should == "-12885"
  end
end

`open -a 'Hex Fiend'`

Spinach.hooks.after_run do
  hex_fiend = Accessibility.application_with_name 'Hex Fiend'
  terminate hex_fiend
  type '\CMD+d'
end
