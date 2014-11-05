#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
module MailForm

  class Base
    include ActiveModel::AttributeMethods
    attribute_method_prefix 'clear_'

    # 1) Add the attribute suffix
    attribute_method_suffix '?'

    def self.attributes(*names)
      attr_accessor(*names)
      define_attribute_methods(names)
    end
    protected

    def clear_attribute(attribute)
      send("#{attribute}=", nil)
    end
    # 2) Implement the logic required by the '?' suffix
    def attribute?(attribute)
      send(attribute).present?
    end
  end
end
