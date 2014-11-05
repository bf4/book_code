#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module RecipesHelper

  def tabs(current_tab)
    content_tag(:div,
                links(current_tab),
                :id => "tabs"
               )
  end

  def links(current_tab)
    nav_items.map do |tab_name, path|
      args = tab_name, path
      if tab_name == current_tab
        args << {:class => 'current'}
      end
      link_to *args
    end.join(separator).html_safe
  end

  def nav_items
    {
    "New" => new_recipe_path,
    "List" => recipes_path,
    "Home" => root_path
    }
  end

  def separator
    content_tag(:span, "|", :class => "separator").html_safe
  end
end
