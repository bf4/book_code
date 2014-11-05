#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'java'
require 'rubygems'
require 'rubeus'

Rubeus::Swing.irb

JFrame.new('Bookie') do |frame|
  frame.layout = BoxLayout.new(:Y_AXIS)

  JSplitPane.new(JSplitPane::HORIZONTAL_SPLIT) do
    JList.new
    JScrollPane.new(:preferred_size => [400, 250]) do
      JTabbedPane.new(:TOP, :SCROLL_TAB_LAYOUT) do
        JTextPane.new
        JEditorPane.new
      end
    end
  end

  JButton.new('Add Chapter')
  frame.visible = true
end
