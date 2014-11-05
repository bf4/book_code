#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def in_place_select_editor(field_id, options = {})
    function =  "new Ajax.InPlaceSelectEditor("
    function << "'#{field_id}', "
    function << "'#{url_for(options[:url])}'"
    function << (', ' + options_for_javascript(
       {
         'selectOptionsHTML' =>
                %('#{escape_javascript(options[:select_options].gsub(/\n/, ""))}')
       }
       )
    ) if options[:select_options]
    function << ')'
    javascript_tag(function)
  end
  def in_place_select_editor_field(object, method, tag_options = {}, 
                                   in_place_editor_options = {})
    tag = ::ActionView::Helpers::InstanceTag.new(object, method, self)
    tag_options = { :tag => "span", 
                    :id => "#{object}_#{method}_#{tag.object.id}_in_place_editor", 
                   :class => "in_place_editor_field"}.merge!(tag_options)
    in_place_editor_options[:url] = 
       in_place_editor_options[:url] || 
       url_for({ :action => "set_#{object}_#{method}", :id => tag.object.id })
    tag.to_content_tag(tag_options.delete(:tag), tag_options) +
    in_place_select_editor(tag_options[:id], in_place_editor_options)
  end
end
