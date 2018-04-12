#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
require "rails_helper"

RSpec.describe PriceCalculator, :aggregate_failures do

  let(:ticket_one) { instance_double(Ticket, price: Money.new(1500)) }
  let(:ticket_two) { instance_double(Ticket, price: Money.new(2000)) }
  let(:calculator) { PriceCalculator.new(
      [ticket_one, ticket_two], discount_code) }

  describe "without a discount code" do
    let(:discount_code) { NullDiscountCode.new }

    it "calculates the price of a list of tickets" do
      expect(discount_code.multiplier).to eq(1.0)
      expect(discount_code.percentage_float).to eq(0)
      expect(calculator.total_price).to eq(Money.new(3500))
      expect(calculator.discount).to eq(Money.new(0))
    end
  end

  describe "with an applicable discount_code" do
    let(:discount_code) { DiscountCode.new(percentage: 25) }

    it "calculates the total price and discount with a promo code" do
      expect(discount_code.multiplier).to eq(0.75)
      expect(discount_code.percentage_float).to eq(0.25)
      expect(calculator.total_price).to eq(Money.new(2625))
      expect(calculator.discount).to eq(Money.new(875))
    end
  end

  describe "with a discount code with a good min value" do
    let(:discount_code) { DiscountCode.new(
        percentage: 25, minimum_amount_cents: 100) }

    it "calculates the total price and discount with a promo code" do
      expect(discount_code.multiplier).to eq(0.75)
      expect(discount_code.percentage_float).to eq(0.25)
      expect(calculator.total_price).to eq(Money.new(2625))
      expect(calculator.discount).to eq(Money.new(875))
    end
  end

  describe "with a discount code with a bad min value" do
    let(:discount_code) { DiscountCode.new(
        percentage: 25, minimum_amount_cents: 5000) }

    it "calculates the total price and discount with a promo code" do
      expect(calculator.total_price).to eq(Money.new(3500))
      expect(calculator.discount).to eq(Money.new(0))
    end
  end

  describe "with an applicable discount_code under max" do
    let(:discount_code) { DiscountCode.new(
        percentage: 25, maximum_discount_cents: 10_000) }

    it "calculates the total price and discount with a promo code" do
      expect(discount_code.multiplier).to eq(0.75)
      expect(discount_code.percentage_float).to eq(0.25)
      expect(calculator.total_price).to eq(Money.new(2625))
      expect(calculator.discount).to eq(Money.new(875))
    end
  end

  describe "with an applicable discount_code over max" do
    let(:discount_code) { DiscountCode.new(
        percentage: 25, maximum_discount_cents: 500) }

    it "calculates the total price and discount with a promo code" do
      expect(discount_code.multiplier).to eq(0.75)
      expect(discount_code.percentage_float).to eq(0.25)
      expect(calculator.total_price).to eq(Money.new(3000))
      expect(calculator.discount).to eq(Money.new(500))
    end
  end

end
