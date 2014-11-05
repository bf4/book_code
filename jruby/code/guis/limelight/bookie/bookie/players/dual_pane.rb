#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
module DualPane
  attr_reader :current_chapter

  def update_preview_pane
    preview_content = RedCloth.new(@current_chapter[:text]).to_html
    preview_content.gsub! /\<br\s+\/>/, "\n"
    scene.preview_pane.text = preview_content
  end

  def current_chapter=(chapter)
    save!
    @current_chapter = chapter
    scene.find("chapter_#{@current_chapter[:title]}").select!
    scene.edit_pane.text = @current_chapter[:text]
    update_preview_pane
    scene.chapter_list.update_selection
  end

  def edit!
    scene.preview_pane.style.height = "0"
    scene.edit_pane.style.height = "90%"
    scene.edit_pane.style.background_color = :sky_blue
    scene.preview_tab.style.background_color = :white
    scene.edit_tab.style.background_color = :sky_blue
  end

  def preview!
    save!
    update_preview_pane
    scene.edit_pane.style.height = "0"
    scene.preview_pane.style.height = "90%"
    scene.preview_tab.style.background_color = :sky_blue
    scene.edit_tab.style.background_color = :white
  end

  def save!
    if @current_chapter
      @current_chapter[:text] = scene.edit_pane.text
      scene.preview_pane.text = @current_chapter[:text]
    end
  end
end
