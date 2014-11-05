#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
require 'java'
require 'rubygems'
require 'cheri/swing'
require 'crypt/gost'

include_class javax.swing.JOptionPane

class String
  def encrypt(pw)
    padded = pw + "\0" * [0, 8 - pw.length].max
    Crypt::Gost.new(padded).encrypt_string(self)
  rescue
    return '(wrong password)'
  end

  def decrypt(pw)
    padded = pw + "\0" * [0, 8 - pw.length].max
    Crypt::Gost.new(padded).decrypt_string(self)
  rescue
    return '(wrong password)'
  end
end

class JunqueNoteApp
  include Cheri::Swing

  def initialize
    swing[:auto]

    @frame = swing.frame('JunqueNote') do |f|
      size 400, 300
      box_layout f, :Y_AXIS

      menu_bar do
        menu('File') do
          menu_item('Open...') {on_click {open} }
          menu_item('Change Password...') {on_click {change_password} }
          menu_item('Save As...') {on_click {save_as} }
          menu_item('Exit') {on_click {exit_app} }
        end

        menu('Edit') do
          menu_item('Undo')                       {on_click {@text_area.text = @state.pop} }
          menu_item('Cut')                        {on_click {@state.push(@text_area.text); @text_area.cut} }
          menu_item('Copy')                       {on_click {@state.push(@text_area.text); @text_area.copy} }
          menu_item('Paste')                      {on_click {@state.push(@text_area.text); @text_area.paste} }

          menu_item('Find...')                    {on_click {find} }
          menu_item('Find Exact Case...')         {on_click {find :case} }
          menu_item('Reverse Find...')            {on_click {find :reverse} }
          menu_item('Reverse Find Exact Case...') {on_click {find :case_reverse} }
          menu_item('Find Next')                  {on_click {find @how, @term} }
        end

        menu('Help') do
          menu_item('About JunqueNote...') {on_click {about} }
        end
      end

      @text_area = text_area('Welcome to JunqueNote!') do
        on_key_pressed {|event| @state.push(@text_area.text); @dirty = true}
      end
    end

    @state = [@text_area.text]
    @frame.visible = true
  end

  def request_filename(button = 'Save')
    pane = JOptionPane.new \
      'Please enter a filename',
      JOptionPane::PLAIN_MESSAGE,
      JOptionPane::OK_CANCEL_OPTION,
      nil,
      [button,'Cancel'].to_java,
      button
    pane.wants_input = true
    pane.create_dialog(@frame, 'Input').show

    button == pane.value ? pane.input_value : nil
  end

  def save_as(filename = nil)
    save_name = filename || request_filename
    return if save_name.nil?

    @filename = save_name

    if @password.nil?
      @password = JOptionPane.show_input_dialog "Please assign a password"
      return if @password.nil?
      confirmation = JOptionPane.show_input_dialog "Please confirm the password"
      return if confirmation.nil?

      if @password != confirmation
        JOptionPane.show_message_dialog(
          @frame,
          "The password and confirmation don't match",
          "Oops",
          JOptionPane::YES_NO_OPTION)

        return
      end
    end

    File.delete @filename if File.exists? @filename
    File.open @filename, 'wb' do |f|
      plaintext = "JunqueNote\n#{@text_area.text.length}\n#{@text_area.text}"
      encrypted = plaintext.encrypt(@password)
      f.write encrypted
    end

    @dirty = false
  end

  def open
    @filename = request_filename 'Open'
    if @filename.nil?
      @frame.dispose
      return
    end

    @password = JOptionPane.show_input_dialog "Please enter the password"
    if @password.nil?
      @frame.dispose
      return
    end

    encrypted = File.open(@filename, 'rb') {|f| f.read}
    init, length, contents = encrypted.decrypt(@password).split($;, 3)

    if init == 'JunqueNote'
      contents = contents[0, length.to_i]
      @text_area.text = contents
      @state = [contents]
      @dirty = false
    else
      JOptionPane.show_message_dialog(
        @frame,
        "The password doesn't match",
        "Oops",
        JOptionPane::YES_NO_OPTION)

      @frame.dispose
    end
  end

  def change_password
    old_password = JOptionPane.show_input_dialog "Please enter the password"
    return if old_password.nil?

    if old_password != @password
      JOptionPane.show_message_dialog(
        @frame,
        "The password doesn't match",
        "Oops",
        JOptionPane::YES_NO_OPTION)

      return
    end

    new_password = JOptionPane.show_input_dialog "Please enter a password"
    return if new_password.nil?
    confirmation = JOptionPane.show_input_dialog "Please confirm the password"
    return if confirmation.nil?

    if new_password != confirmation
      JOptionPane.show_message_dialog(
        @frame,
        "The password and confirmation don't match",
        "Oops",
        JOptionPane::YES_NO_OPTION)

      return
    end

    @password = new_password

    File.delete @filename if File.exists? @filename
    File.open @filename, 'wb' do |f|
      plaintext = "JunqueNote\n#{@text_area.text.length}\n#{@text_area.text}"
      encrypted = plaintext.encrypt(@password)
      f.write encrypted
    end

    @dirty = false
  end

  def exit_app
    should_save = if @dirty
      0 == JOptionPane.show_confirm_dialog(
        nil,
        "Wanna save first?",
        "Quittin' time",
        JOptionPane::YES_NO_OPTION)
    else
      false
    end

    save_as(@filename) if should_save
    @frame.dispose
  end

  def about
    JOptionPane.show_message_dialog(
      @frame,
      "A hypothetical JRuby port of LockNote",
      "About JunqueNote",
      JOptionPane::INFORMATION_MESSAGE)
  end

  def find(how = nil, term = nil)
    term ||= JOptionPane.show_input_dialog "Please enter the search term"
    return unless term

    @how = how
    @term = term

    pattern, backwards = case how
    when :case
      [/#{term}/, false]
    when :reverse
      [/#{term.reverse}/i, true]
    when :case_reverse
      [/#{term.reverse}/, true]
    else
      [/#{term}/i, false]
    end

    position = @text_area.get_selection_start || 0
    contents = @text_area.text

    if backwards
      contents.reverse!
      position = contents.length - position
    end

    next_position = contents.index pattern, position + 1

    if next_position
      next_position =
        contents.length -
        next_position -
        term.length if backwards

      @text_area.set_selection_start next_position
      @text_area.set_selection_end next_position + term.length
    end
  end
end

if __FILE__ == $0
  JunqueNoteApp.new
end
