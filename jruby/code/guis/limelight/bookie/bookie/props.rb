#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
root do
  center do
    chapter_list :id => 'chapter_list'
    dual_pane :id => 'dual_pane' do
      tabs do
        tabs_shadow
        tabs_holder do
          tab_button :text             => 'Edit',
                     :id               => 'edit_tab',
                     :on_mouse_clicked => 'scene.dual_pane.edit!',
                     :styles           => 'left_tab'
          tab_button :text             => 'Preview',
                     :id               => 'preview_tab',
                     :on_mouse_clicked => 'scene.dual_pane.preview!',
                     :styles           => 'right_tab'
        end
      end
      preview_pane :id => 'preview_pane'
      edit_pane :players => 'text_area',
      :id => 'edit_pane'
    end
  end
  add_chapter :text => 'Add Chapter'
end
