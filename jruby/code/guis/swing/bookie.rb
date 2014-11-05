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
require 'redcloth'

classes = %w(JFrame JButton JList
             JEditorPane JSplitPane JTabbedPane JTextPane
             DefaultListModel ListSelectionModel BoxLayout
             text.html.HTMLEditorKit)

classes.each do |c|
  java_import "javax.swing.#{c}"
end

java_import java.awt.Dimension


edit    = JTextPane.new
preview = JEditorPane.new

preview.editable   = false
preview.editor_kit = HTMLEditorKit.new
preview.document   = preview.editor_kit.create_default_document


chapters = JList.new(DefaultListModel.new)
chapters.selection_mode = ListSelectionModel::SINGLE_SELECTION

class << chapters
  def add_chapter
    count = model.size
    model.add_element count + 1
    selection_model.set_selection_interval count, count
  end
end

chapters.add_chapter


contents = Hash.new('')

chapters.add_list_selection_listener do |e|
  unless e.value_is_adjusting
    new_index = e.source.get_selected_index
    old_index = [e.first_index, e.last_index].find { |i| i != new_index }

    contents[old_index], edit.text = edit.text, contents[new_index]
    preview.text = RedCloth.new(edit.text).to_html
  end
end


tabbed_pane = JTabbedPane.new JTabbedPane::TOP, JTabbedPane::SCROLL_TAB_LAYOUT
tabbed_pane.add_tab 'Edit', edit
tabbed_pane.add_tab 'Preview', preview

tabbed_pane.add_change_listener do |event|
  if tabbed_pane.selected_component == preview
    preview.text = RedCloth.new(edit.text).to_html
  end
end


split_pane = JSplitPane.new JSplitPane::HORIZONTAL_SPLIT
split_pane.add chapters
split_pane.add tabbed_pane


button = javax.swing.JButton.new 'Add Chapter'
button.size = Dimension.new 40, 40
button.add_action_listener { chapters.add_chapter }


frame = JFrame.new 'Bookie'
frame.size   = Dimension.new 500, 300
frame.layout = BoxLayout.new frame.content_pane, BoxLayout::Y_AXIS
frame.add split_pane
frame.add button
frame.visible = true
