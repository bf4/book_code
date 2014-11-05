#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
class ApplicationFormBuilder < ActionView::Helpers::FormBuilder

  def field_item(attribute, text = nil, &block)
    @template.content_tag :li do
      @template.concat @template.label(attribute, text)
      yield
    end
  end

  def errors_on(attribute)
    if @object.errors[attribute].any?
      @template.content_tag(:span,
        @object.errors[attribute].to_sentence,
        class: 'error'
      )
    end
  end
  
end
