#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
class Note
  attr_reader :path

  @@app = nil
  @@titles = {}

  def self.open(*args)
    @@app.new *args
  end

  DefaultOptions = {
    :password => 'password',
    :confirmation => true
  }

  def save_as(name, with_options = {})
    options = DefaultOptions.merge with_options #(1)

    @path = @@app.path_to(name)                 #(2)
    File.delete @path if File.exist? @path

    menu 'File', 'Save As...'                   #(3)

    enter_filename @path                        #(4)
    assign_password options
  end


  def exit!(with_options = {})
    options = DefaultOptions.merge with_options
    menu 'File', 'Exit'
    @prompted[:to_confirm_exit] = dialog(@@titles[:exit]) do |d|
      d.click(options[:save_as] ? @@titles[:yes] : @@titles[:no])
    end
    if options[:save_as]
      path = @@app.path_to options[:save_as]
      enter_filename path
      assign_password options
    end
  end

  def change_password(with_options = {})
    old_options = {
      :password => with_options[:old_password]} #(5)

    new_options = {
      :password => with_options[:password],
      :confirmation =>
        with_options[:confirmation] ||
        with_options[:password]}                #(6)

    menu 'File', 'Change Password...'

    unlock_password old_options
    assign_password new_options
  end

  def about
    menu 'Help', @@titles[:about_menu]

    @prompted[:with_help_text] = dialog(@@titles[:about]) do |d|
      d.click '_OK'
    end
  end

  [:undo, :cut, :copy, :paste, :find_next].each do |method|
    item = method.to_s.split('_').collect {|m| m.capitalize}.join(' ')
    define_method(method) {menu 'Edit', item, :wait} #(7)
  end

  def has_prompted?(kind)
    @prompted[kind]
  end

private

  def enter_filename(path, approval = '_Save')
    dialog(@@titles[:file]) do |d|
      d.type_in path
      d.click approval
    end
  end

  def unlock_password(with_options = {})
    options = DefaultOptions.merge with_options
    options[:confirmation] = false #(8)

    enter_password options
    watch_for_error
  end

  def assign_password(with_options = {})
    options = DefaultOptions.merge with_options

    enter_password options
    watch_for_error

    if @prompted[:with_error]
      enter_password :cancel_password => true #(9)
    end
  end
end


require 'fileutils'

class Note
  def self.fixture(name)
    source = @@app.path_to(name + 'Fixture')
    target = @@app.path_to(name)

    FileUtils.rm target if File.exist? target
    FileUtils.copy source, target
  end
end
