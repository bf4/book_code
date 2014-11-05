#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
require 'windows_gui'
require 'note'


class LockNote < Note
  include WindowsGui

  @@app = LockNote
  @@titles =
  {
    :file => 'Save As',
    :exit  => 'Steganos LockNote',
    :about => 'About Steganos LockNote...',
    :about_menu  => 'About',
    :dialog => 'Steganos LockNote',
    :yes => '_Yes',
    :no => '_No',
  }
  
  BasePath = "C:\\LockNote"
  WindowsGui.load_symbols "#{BasePath}\\src\\resource.h"
  WindowsGui.load_symbols "#{BasePath}\\src\\atlres.h"
  ID_HELP_ABOUT = ID_APP_ABOUT  
  ID_FILE_EXIT = ID_APP_EXIT
      
  def initialize(name = 'LockNote', with_options = {})
    options = DefaultOptions.merge(with_options)
    
    @prompted = {}
    @path = LockNote.path_to(name)
    
    system 'start "" "' + @path + '"'
    unlock_password options
    
    if @prompted[:with_error] || options[:cancel_password]
      @main_window = Window.new 0
      sleep 1.0
    else
      @main_window = Window.top_level "#{name} - Steganos LockNote"
      @edit_window = @main_window.child "ATL:00434310"

      set_foreground_window @main_window.handle
    end
  end
  
  def select_all
    keystroke VK_CONTROL, ?A
  end
  
  def text
    @edit_window.text
  end
  
  def text=(new_text)
    select_all
    keystroke VK_BACK
    type_in new_text
  end

  def selection
    result = send_message @edit_window.handle, EM_GETSEL, 0, 0
    bounds = [result].pack('L').unpack('SS')
    bounds[0]...bounds[1] #(1)
  end
  
  def go_to(where)
    case where
      when :beginning
        keystroke VK_CONTROL, VK_HOME
      when :end
        keystroke VK_CONTROL, VK_END
    end
  end
  
  WholeWord = 0x0410
  ExactCase = 0x0411
  SearchUp  = 0x0420
  def find(term, with_options={})
    menu 'Edit', 'Find...'
    appeared = dialog('Find') do |d|
      type_in term
      d.click WholeWord if with_options[:whole_word]
      d.click ExactCase if with_options[:exact_case]
      d.click SearchUp if :back == with_options[:direction]
      d.click IDOK
      d.click IDCANCEL
    end
    raise 'Find dialog did not appear' unless appeared
  end
  
  def running?
    @main_window.handle != 0 && is_window(@main_window.handle) != 0
  end
  
  def menu(name, item, wait = false)
    multiple_words = /[.]/
    single_word = /[ .]/
    [multiple_words, single_word].each do |pattern|
      words = item.gsub(pattern, '').split
      const_name = ['ID', name, *words].join('_').upcase
      msg = WM_COMMAND
      
      begin
        id = LockNote.const_get const_name
        action = wait ? :send_message : :post_message
        
        return send(action, @main_window.handle, msg, id, 0)
      rescue NameError
      end
    end
  end

  def self.path_to(name)
    "#{BasePath}\\#{name}.exe"
  end  

private

  def enter_password(with_options = {})
    options = DefaultOptions.merge with_options

    @prompted[:for_password] = dialog(@@titles[:dialog]) do |d|
      type_in options[:password]

      confirmation =
        options[:confirmation] == true ?
        options[:password] :
        options[:confirmation]    
      
      if confirmation
        keystroke VK_TAB
        type_in confirmation
      end
          
      d.click options[:cancel_password] ? IDCANCEL : IDOK
    end
  end
  
  ErrorIcon = 0x0014
  def watch_for_error
    if @prompted[:for_password]
      @prompted[:with_error] = dialog(@@titles[:dialog]) do |d|
        d.click IDCANCEL if get_dlg_item(d.handle, ErrorIcon) > 0 #(2)
      end
    end
  end
end
