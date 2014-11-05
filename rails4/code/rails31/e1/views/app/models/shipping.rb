#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
class Shipping
    ShippingOption = Struct.new(:id, :name)

    class ShippingType
      attr_reader :type_name, :options
      def initialize(name)
        @type_name = name
        @options = []
      end
      def <<(option)
        @options << option
      end
    end

    ground    = ShippingType.new("SLOW")
    ground   << ShippingOption.new(100, "Ground Parcel")
    ground   << ShippingOption.new(101, "Media Mail")

    regular   = ShippingType.new("MEDIUM")
    regular  << ShippingOption.new(200, "Airmail")
    regular  << ShippingOption.new(201, "Certified Mail")

    priority  = ShippingType.new("FAST")
    priority << ShippingOption.new(300, "Priority")
    priority << ShippingOption.new(301, "Express")

    OPTIONS = [ ground, regular, priority ]
end
