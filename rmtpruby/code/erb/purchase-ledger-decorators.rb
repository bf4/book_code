#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
require "erb"
require "delegate"

LineItem = Struct.new(:name, :units, :unit_price) do
  def price
    units * unit_price
  end
end

class PurchaseLedger
  def initialize
    @line_items = [
      LineItem.new("Ol' Janx Spirit",             282,   9900),
      LineItem.new("Eau de Santraginus V",        300,   200),
      LineItem.new("Arcturan Mega-Gin",           150,   5000),
      LineItem.new("Fallian Marsh Gas",           1_000, 200),
      LineItem.new("Qalactin Hypermint Extract",  25,    2000),
      LineItem.new("Algolian Suntiger, teeth of", 300,   10000),
      LineItem.new("Zamphuor",                    3,     4000),
      LineItem.new("Olives",                      200,   12),
    ]
    @total = @line_items.reduce(0) { |t, i| t + i.price }
  end

  def report
    template = File.read("purchase-ledger-decorators.erb")
    renderer = ERB.new(template, nil, ">")
    renderer.result(binding)
  end
end

class Number < SimpleDelegator
  def initialize(number)
    @number = number
    super
  end

  def with_commas
    @number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  end
end

class Currency < SimpleDelegator
  def initialize(number)
    @number = number
    super
  end

  def to_s
    "£" + Number.new("%.2f" % (@number / 100)).with_commas
  end
end

ledger = PurchaseLedger.new
puts ledger.report

