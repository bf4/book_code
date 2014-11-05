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
      @template.concat errors_on(attribute)
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

  def email_field_item(attribute, *args)
    field = email_field_tag(attribute, @object.send(attribute), *args)
    field_item do
      @template.concat field
    end
  end
  def number_field_item(attribute, *args)
    field = number_field_tag(attribute, @object.send(attribute), *args)
    field_item do
      @template.concat field
    end
  end
  def range_field_item(attribute, *args)
    field = range_field_tag(attribute, @object.send(attribute), *args)
    field_item do
      @template.concat field
    end
  end

  def guess_field_item(attribute, *args)
    # Match on attribute name...
    if attribute =~ /_url$/
      url_field_item(attribute, *args)
      # Match on attribute column type
    elsif @object.class.columns_hash[attribute.to_s].type == :integer
      number_field_item(attribute, *args)
    else
      # More insanity...
    end
  end
  
end
