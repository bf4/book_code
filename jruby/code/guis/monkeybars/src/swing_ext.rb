#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
java_import javax.swing.DefaultListModel
java_import javax.swing.DefaultListSelectionModel

class DefaultListSelectionModel
  def single_index
    get_min_selection_index
  end

  def single_index=(i)
    set_selection_interval i, i
  end
end
