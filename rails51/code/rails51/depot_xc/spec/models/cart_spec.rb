#---
# Excerpted from "Agile Web Development with Rails 5.1",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rails51 for more book information.
#---

require 'rails_helper'

RSpec.describe Cart, type: :model do
  
  fixtures :products
  subject(:cart) { Cart.new }

  let(:book_one) { products(:ruby) }
  let(:book_two) { products(:two) }

  describe "#add_product" do
    context "adding unique products" do
      before do
        cart.add_product(book_one).save!
        cart.add_product(book_two).save!
      end

      it "has two line items" do
        expect(cart.line_items.size).to eq(2)
      end
      it "has a total price of the two items' price" do
        expect(cart.total_price).to eq(book_one.price + book_two.price)
      end
    end

    context "adding duplicate products" do
      before do
        cart.add_product(book_one).save!
        cart.add_product(book_one).save!
      end

      it "has one line item" do
        expect(cart.line_items.size).to eq(1)
      end
      it "has a line item with a quantity of 2" do
        expect(cart.line_items.first.quantity).to eq(2)
      end
      it "has a total price of twice the product's price" do
        expect(cart.total_price).to eq(book_one.price * 2)
      end
    end
  end
  
end
