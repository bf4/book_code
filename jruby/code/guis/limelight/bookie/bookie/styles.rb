#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
default_border_color     { border_color 'b9b9b9' }
default_background_color { background_color :white }

fill_parent {
  width '100%'
  height '100%'
}

bookie {
  extends :fill_parent
}

center {
  horizontal_alignment :center
  vertical_alignment :center
}

root {
  extends :default_background_color, :fill_parent
  text_color :white
  font_size 18
}

center {
  width '100%'
  height '90%'
}

chapter_list {
  width '10%'
  height '100%'
  bottom_margin 8
}

chapter {
  extends :default_border_color, :default_background_color, :center
  height 30
  width "100%"
  secondary_background_color 'f0f0f0'
  gradient :on
  bottom_border_width 1
  right_border_width 1
}

dual_pane {
  width '90%'
  height '100%'
}

edit_button {
  width '50%'
  height '10%'
}

preview_button {
  width '50%'
  height '10%'
}

add_chapter {
  extends :default_border_color, :default_background_color, :center
  width '22%'
  height '8%'
  rounded_corner_radius 4
  secondary_background_color 'f0f0f0'
  gradient :on
  gradient_angle 270
  border_width 1
  left_margin 4
  padding 4
}

tabs {
 width "100%"
 height '10%'
 horizontal_alignment :center
}

tab_button {
  extends :default_border_color, :default_background_color
  horizontal_alignment :center
  vertical_alignment :center
  secondary_background_color 'f0f0f0'
  gradient :on
  gradient_angle 270
  padding 5
  hover {
    secondary_background_color :sky_blue
  }
}

tabs_holder {
  extends :fill_parent
  float :on
  y '15%'
  x '37%'
}

tabs_shadow {
  extends :default_border_color
  extends :fill_parent
  top_margin '50%'
  left_margin 8
  right_margin 8
  top_border_width 1
  left_border_width 1
  right_border_width 1
  background_color 'f0f0f0'
}

left_tab {
  top_left_rounded_corner_radius 4
  bottom_left_rounded_corner_radius 4
  border_width 1
}

right_tab {
  top_right_rounded_corner_radius 4
  top_right_border_width 1
  bottom_right_rounded_corner_radius 4
  bottom_right_border_width 1
  left_border_width 0
  right_border_width 1
  top_border_width 1
  bottom_border_width 1
}

preview_pane {
  extends :default_border_color, :default_background_color
  width "100%"
  height "90%"
  left_border_width 1
  right_border_width 1
  bottom_border_width 1
  left_margin 8
  right_margin 8
  bottom_margin 8
  font_size 16
  font_face "times"
}

edit_pane {
  width "100%"
  height "90%"
  left_margin 8
  right_margin 8
  bottom_margin 8
}

###### Styles of styling text

p {
  top_margin 3
  bottom_margin 3
  border_width 1
  border_color :blue
}

br {
}

strong {
  font_style "bold"
}

em {
  font_style "italic"
}
