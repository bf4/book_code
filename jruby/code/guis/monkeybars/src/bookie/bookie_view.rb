#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
class BookieView < ApplicationView
  set_java_class 'bookie.Bookie'

  map :view  => 'edit.text',
      :model => 'text'

  map :view  => 'preview.text',
      :model => 'text',
      :using => ['redcloth', nil]

  def redcloth(text)
    RedCloth.new(text).to_html
  end

  map :view  => 'chapters.selection_model.single_index',
      :model => 'index'

  map :view  => 'chapters.model',
      :model => 'chapters',
      :using => ['list_items', nil]

  def list_items(chapters)
    items = DefaultListModel.new
    1.upto(chapters.size).each { |n| items.add_element n }
    items
  end

  define_signal :name    => :fix_selection,
                :handler => :fix_selection

  def fix_selection(model, transfer)
    chapters.selection_model.single_index = model.index
  end
end
