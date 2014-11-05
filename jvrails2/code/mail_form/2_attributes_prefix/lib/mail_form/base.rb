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
    include ActiveModel::AttributeMethods  # 1) attribute methods behavior
    attribute_method_prefix 'clear_'       # 2) clear_ is attribute prefix

    def self.attributes(*names)
      attr_accessor(*names)

      # 3) Ask to define the prefix methods for the given attribute names
      define_attribute_methods(names)
    end

    protected

    # 4) Since we declared a "clear_" prefix, it expects to have a
    # "clear_attribute" method defined, which receives an attribute
    # name and implements the clearing logic.
    def clear_attribute(attribute)
      send("#{attribute}=", nil)
    end
  end
end
