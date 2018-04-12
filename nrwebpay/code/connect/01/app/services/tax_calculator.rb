#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class TaxCalculator

  attr_accessor :user, :cart_id, :address, :items

  def initialize(user:, cart_id:, address:, items:)
    @user = user
    @cart_id = cart_id
    @address = address
    @items = items
  end

  def origin
    TaxCloud::Address.new(
        address1: "1060 W. Addison", city: "Chicago",
        state: "IL", zip5: "60613")
  end

  def destination
    TaxCloud::Address.new(
        address1: address.address_1, address2: address.address_2,
        city: address.city, state: address.state,
        zip5: address.zip)
  end

  def transaction
    @transaction ||= begin
      transaction = TaxCloud::Transaction.new(
          customer_id: user.id, cart_id: cart_id,
          origin: origin, destination: destination)
      items.each_with_index do |item, index|
        transaction.cart_items << item.cart_item(index)
      end
      transaction
    end
  end

  def lookup
    @lookup ||= transaction.lookup
  end

  def tax_amount
    lookup.tax_amount.to_money
  end

  def itemized_taxes
    types = items.map(&:type).map { |t| "#{t}_cents".to_sym }
    taxes = lookup.cart_items.map do |item|
      item.tax_amount * 100
    end
    Hash[types.zip(taxes)]
  end

  def authorized_with_capture(order_id)
    lookup
    transaction.order_id = order_id
    transaction.authorized_with_capture
  end

  def return(order_id)
    lookup
    transaction.order_id = order_id
    transaction.returned
  end

  class Item

    attr_reader :price, :quantity, :type

    def self.create(type, quantity, price)
      case type
      when :ticket then TicketItem.new(type, quantity, price)
      when :shipping then ShippingItem.new(type, quantity, price)
      when :processing then ProcessingItem.new(type, quantity, price)
      end
    end

    def initialize(type, quantity, price)
      @type = type
      @price = price
      @quantity = quantity
    end

  end

  class TicketItem < Item

    def cart_item(index)
      TaxCloud::CartItem.new(
          index: index, item_id: "Ticket",
          tic: "91083", price: price.to_f,
          quantity: quantity)
    end

  end

  class ShippingItem < Item

    def cart_item(index)
      TaxCloud::CartItem.new(
          index: index, item_id: "Shipping",
          tic: "11000", price: price.to_f,
          quantity: quantity)
    end

  end

  class ProcessingItem < Item

    def cart_item(index)
      TaxCloud::CartItem.new(
          index: index, item_id: "Processing",
          tic: "10010", price: price.to_f,
          quantity: quantity)
    end

  end

end
