#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
class TaggedBuilder < ActionView::Helpers::FormBuilder
  
  #  <p>
  #  <label for="product_description">Description</label><br/>
  #  <%= form.text_area 'description'  %>
  #</p>
  
  def self.create_tagged_field(method_name)
    define_method(method_name) do |label, *args|
      @template.content_tag("p",
        @template.content_tag("label" , 
                              label.to_s.humanize, 
                              :for => "#{@object_name}_#{label}") + 
        "<br/>" +
        super(label, *args))
    end
  end
  
  field_helpers.each do |name|
    create_tagged_field(name)
  end

end
