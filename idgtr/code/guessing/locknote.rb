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
require 'set'


class LockNote < Note
  include WindowsGui

  @@app = LockNote
  @@titles =
  {
    :file => 'Save As',
    :exit  => 'Steganos LockNote',
    :about => 'About Steganos LockNote...',
    :about_menu  => 'About',
    :dialog => 'Steganos LockNote'
  }

  BasePath = "C:\\LockNote"
  WindowsGui.load_symbols "#{BasePath}\\src\\resource.h"
  WindowsGui.load_symbols "#{BasePath}\\src\\atlres.h"
  ID_HELP_ABOUT = ID_APP_ABOUT

  DefaultOptions = {
    :password => 'password',
    :confirmation => 'password'
  }

  EditControl = 'ATL:00434310'

  def initialize(name = 'LockNote', with_options = {})
    options = DefaultOptions.merge(with_options)

    @prompted = {}
    @path = LockNote.path_to name

    system 'start "" "' + @path + '"'
    unlock_password options

    if @prompted[:with_error] || options[:cancel_password]
      @main_window = Window.new 0
      sleep 1.0
    else
      @main_window = Window.top_level "#{name} - Steganos LockNote"
      @edit_window = @main_window.child EditControl

      set_foreground_window @main_window.handle
    end
  end

  def select_all
    keystroke VK_CONTROL, 'A'.to_byte
  end

  def text
    @edit_window.text
  end

  def text=(new_text)
    select_all
    delete
    type_in new_text
  end

  def selection
    result = send_message @edit_window.handle, EM_GETSEL, 0, 0
    bounds = [result].pack('L').unpack('SS')
    bounds[0]...bounds[1]
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

      begin
        id = LockNote.const_get const_name
        action = wait ? :send_message : :post_message

        return send(action, @main_window.handle, WM_COMMAND, id, 0)
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

      if options[:confirmation]
        keystroke VK_TAB
        type_in options[:confirmation]
      end

      d.click options[:cancel_password] ? IDCANCEL : IDOK
    end
  end

  ErrorIcon = 0x0014

  def watch_for_error
    if @prompted[:for_password]
      @prompted[:with_error] = dialog(@@titles[:dialog]) do |d|
        d.click IDCANCEL if get_dlg_item(d.handle, ErrorIcon) > 0
      end
    end
  end
end


srand
$seed ||= srand #(1)
srand $seed
puts "Using random seed #{$seed}"

class LockNote
  def paste
    case rand(3)
    when 0
      menu 'Edit', 'Paste'
      puts 'Pasting from the menu'
    when 1
      keystroke VK_CONTROL, 'V'.to_byte
      puts 'Pasting from a keyboard shortcut'
    when 2
      @main_window.click EditControl, :right #(2)
      type_in 'P'
      puts 'Pasting from a context menu'
    end
  end
end

class LockNote
  @@default_way = :random

  def self.def_action(name, options, way = nil)
    define_method name do
      keys = options.keys.sort {|k| k.to_s}

      way ||= @@default_way #(3)
      key = case way
        when nil;     keys.last
        when :random; keys[rand(keys.size)]
        else          way
      end

      action = options[key]

      case key
      when :menu
        menu *action
        puts "Performing #{name} from the menu bar"

      when :keyboard
        keystroke *action
        sleep 0.5
        puts "Performing #{name} from a keyboard shortcut"

      when :context
        @main_window.click LockNote::EditControl, :right
        sleep 0.5
        type_in action
        sleep 0.5
        puts "Performing #{name} from a context menu"

      else
        raise "Don't know how to use #{key}"
      end
    end
  end
end

require 'logger'

class SimpleFormatter < Logger::Formatter #(4)
  def call(severity, time, progname, msg)
    msg2str(msg) + "\n"
  end
end

$logger = Logger.new STDERR
$logger.formatter = SimpleFormatter.new #(5)

class LockNote
  @@actions = Set.new

  def self.def_action(name, options, way = nil)
    @@actions << name

    define_method name do
      way ||= @@default_way

      keys = options.keys.sort_by {|k| k.to_s}
      key = case way
        when nil;     keys.last
        when :random; keys[rand(keys.size)]
        else          way
      end

      action = options[key]

      case key
      when :menu
        menu *action
        $logger.info "menu '#{action[0]}', '#{action[1]}'"

      when :keyboard
        keystroke *action
        sleep 0.5
        $logger.info "keystroke " + action.join(', ')

      when :context
        @main_window.click LockNote::EditControl, :right
        sleep 0.5
        type_in action
        sleep 0.5
        $logger.info "@main_window.click EditControl, :right"
        $logger.info "type_in '#{action}'"

      else
        raise "Don't know how to use #{key}"
      end
    end
  end
end

class LockNote
  def_action :paste,
    :menu => ['Edit', 'Paste', :wait],
    :keyboard => [VK_CONTROL, 'V'.to_byte],
    :context => 'p'
end

class LockNote
  def_action :undo,
    :menu => ['Edit', 'Undo', :wait],
    :keyboard => [VK_CONTROL, 'Z'.to_byte]

  def_action :cut,
    :menu => ['Edit', 'Cut', :wait],
    :keyboard => [VK_CONTROL, 'X'.to_byte],
    :context => 't'

  def_action :copy,
    :menu => ['Edit', 'Copy', :wait],
    :keyboard => [VK_CONTROL, 'C'.to_byte],
    :context => 'c'

  def_action :delete,
    :keyboard => [VK_BACK],
    :context => 'd'

  def_action :select_all,
    :menu => ['Edit', 'Select All', :wait],
    :keyboard => [VK_CONTROL, 'A'.to_byte],
    :context => 'a'
end

class LockNote
  def_action :find_next,
    :menu => ['Edit', 'Find Next', :wait],
    :keyboard => [VK_F3]
end

class LockNote
  def random_action
    raise "LockNote is not running" unless running?
    choices = @@actions.to_a
    action = choices[rand(choices.size)]
    send action
  end

  def random_typing
    num = 1 + rand(50)
    random_text = (1..num).collect {rand(26) + 'a'.to_byte}.pack 'c*'
    type_in random_text
    $logger.info "Typing #{random_text}"
  end

  def random_clicking
    num = 1 + rand(10)
    num.times do
      point = nil
      (rand(2) + 1).times do
        point = @main_window.click(EditControl, :left, point || :random)
        $logger.info "Clicking #{point.inspect}"
      end
    end
  end

  @@actions << :random_typing << :random_clicking

  def random_typing
    num = 1 + rand(50)
    random_text = (1..num).collect {rand(26) + 'a'.to_byte}.pack 'c*'
    type_in random_text
    $logger.info "type_in '#{random_text}'"
  end

  def random_clicking
    num = 1 + rand(10)
    num.times do
      point = nil
      (rand(2) + 1).times do
        point = @main_window.click(EditControl, :left, point || :random)
        $logger.info "@main_window.click EditControl, :left, " + point.inspect
      end
    end
  end
end
