#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class AlternatingColorsFormBuilder < ActionView::Helpers::FormBuilder
  (field_helpers -
   %w(check_box radio_button hidden_field label)).each do |selector|
    src = <<-END_SRC
      def #{selector}(field, options = {})
        @template.content_tag("p",
                              label(field) + ": " + super,
                              :class => @template.cycle("", "alt-row"))
      end
    END_SRC
    class_eval src, __FILE__, __LINE__
  end
end

