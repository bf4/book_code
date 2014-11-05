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
  
  def menu_tab(name, opts)
    content_tag('li', link_to(name, opts),
      :class => yield(@controller.controller_name,@controller.action_name) ? 'current' : nil)
  end
  
  def rtl?
    Locale.active.language.direction == 'rtl'
  end
  
  def translated_options(options_array=[])
    options_array.collect{|option| option.kind_of?(Array) ? [option.first.to_s.t, option.last] : [option.to_s.t,option]}
  end
  
  def supported_languages_for_select
    options_for_select(
      SUPPORTED_LANGUAGES.collect{|iso_code| [Language.find_by_iso_639_1(iso_code).english_name.t, iso_code] }, 
      Locale.active ? Locale.active.language.iso_639_1 : nil
    )
  end
  
end
