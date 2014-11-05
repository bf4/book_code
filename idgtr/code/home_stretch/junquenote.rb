#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
require 'swing_gui'
require 'junquenote_app'
require 'note'

class JunqueNote < Note
  @@app = JunqueNote
  @@titles =
  {
    :file => "Input",
    :exit  => "Quittin' time",
    :about => "About JunqueNote",
    :about_menu  => "About JunqueNote...",
    :yes => "Yes",
    :no => "No"
  }

  include SwingGui

  def initialize(name = nil, with_options = {})
    options = DefaultOptions.merge(with_options)

    @prompted = {}
    @path = JunqueNote.path_to(name) if name
    @program = JunqueNoteApp.new
    @main_window = JFrameOperator.new 'JunqueNote'
    @edit_window = JTextAreaOperator.new @main_window
    @menu_bar = JMenuBarOperator.new @main_window

    if name
      menu 'File', 'Open...'
      enter_filename @path, '_Open'
      unlock_password options
    end

    if @prompted[:with_error] || options[:cancel_password]
      @program = nil
    end
  end

  def text
    @edit_window.text
  end

  def text=(message)
    @edit_window.select_all
    @edit_window.type_text message
  end

  def selection
    first = @edit_window.get_selection_start
    last = @edit_window.get_selection_end
    Range.new(first, last - 1)
  end

  def go_to(where)
    case where
      when :beginning
        @edit_window.set_caret_position 0
      when :end
        @edit_window.set_caret_position text.length
    end
  end

  def find(term, with_options={})
    command = 'Find...'
    command = 'Find Exact Case...' if with_options[:exact_case]
    command = 'Reverse ' + command if :back == with_options[:direction]

    menu 'Edit', command

    dialog('Input') do |d|
      d.type_in term
      d.click 'OK'
    end
  end

  def running?
    @main_window && @main_window.visible
  end

  def menu(name, item, wait = false)
    action = wait ? :push_menu : :push_menu_no_block
    @menu_bar.send action,  name + '|' + item, '|'
  end

  def select_all
    @edit_window.select_all
  end

  def self.path_to(name)
    name + '.junque'
  end

private

  def enter_password(with_options = {})
    options = DefaultOptions.merge with_options

    @prompted[:for_password] = single_password_entry \
      options[:password], options[:cancel_password]

    confirmation =
      options[:confirmation] == true ?
      options[:password] :
      options[:confirmation]

    if @prompted[:for_password] && confirmation
      single_password_entry confirmation, false
    end
  end

  def single_password_entry(password, cancel)
    dialog('Input') do |d|
      d.type_in password
      d.click(cancel ? 'Cancel' : 'OK')
    end
  end

  def watch_for_error
    if @prompted[:for_password]
      @prompted[:with_error] = dialog('Oops') do |d|
        d.click 'OK'
      end
    end
  end
end
