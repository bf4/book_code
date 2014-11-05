#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
require 'java'
require 'jemmy.jar'
require 'junquenote_app'

java_import 'org.netbeans.jemmy.JemmyProperties'
java_import 'org.netbeans.jemmy.TestOut'

%w(Frame TextArea MenuBar Dialog Button).each do |o| #(1)
  java_import "org.netbeans.jemmy.operators.J#{o}Operator"
end

JemmyProperties.set_current_timeout 'DialogWaiter.WaitDialogTimeout', 3000 #(2)
JemmyProperties.set_current_output TestOut.get_null_output #(3)

JunqueNoteApp.new
main_window = JFrameOperator.new 'JunqueNote'

puts "The main window's object ID is #{main_window.object_id}."


edit = JTextAreaOperator.new main_window #(4)
edit.type_text "this is some text"       #(5)


menu = JMenuBarOperator.new main_window
menu.push_menu_no_block 'File|Exit', '|'


dialog = JDialogOperator.new "Quittin' time"
button = JButtonOperator.new dialog, "No"
button.push
