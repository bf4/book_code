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
    include ActiveModel::Conversion
    extend ActiveModel::Naming
    extend ActiveModel::Translation
    include ActiveModel::Validations
    include ActiveModel::AttributeMethods

    attribute_method_prefix 'clear_'
    attribute_method_suffix '?'

    # 1) Define a class attribute and initialize it
    class_attribute :attribute_names
    self.attribute_names = []

    def self.attributes(*names)
      attr_accessor(*names)
      define_attribute_methods(names)

      # 2) Add new names as they are defined
      self.attribute_names += names
    end

    def deliver
      if valid?
        MailForm::Notifier.contact(self).deliver
      else
        false
      end
    end

    def initialize(attributes = {})
      attributes.each do |attr, value|
        self.public_send("#{attr}=", value)
      end if attributes
    end

    def persisted?
      false
    end

    protected

    def clear_attribute(attribute)
      send("#{attribute}=", nil)
    end

    def attribute?(attribute)
      send(attribute).present?
    end
  end
end