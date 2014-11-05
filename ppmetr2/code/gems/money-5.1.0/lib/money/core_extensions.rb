#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# Open +Numeric+ to add new method.
class Numeric

  # Converts this numeric into a +Money+ object in the given +currency+.
  #
  # @param [Currency, String, Symbol] currency
  #   The currency to set the resulting +Money+ object to.
  #
  # @return [Money]
  #
  # @example
  #   100.to_money                   #=> #<Money @fractional=10000>
  #   100.37.to_money                #=> #<Money @fractional=10037>
  #   BigDecimal.new('100').to_money #=> #<Money @fractional=10000>
  #
  # @see Money.from_numeric
  #
  def to_money(currency = nil)
    Money.from_numeric(self, currency || Money.default_currency)
  end
end

# Open +String+ to add new methods.
class String

  # Parses the current string and converts it to a +Money+ object.
  # Excess characters will be discarded.
  #
  # @param [Currency, String, Symbol] currency
  #   The currency to set the resulting +Money+ object to.
  #
  # @return [Money]
  #
  # @example
  #   '100'.to_money                #=> #<Money @fractional=10000>
  #   '100.37'.to_money             #=> #<Money @fractional=10037>
  #   '100 USD'.to_money            #=> #<Money @fractional=10000, @currency=#<Money::Currency id: usd>>
  #   'USD 100'.to_money            #=> #<Money @fractional=10000, @currency=#<Money::Currency id: usd>>
  #   '$100 USD'.to_money           #=> #<Money @fractional=10000, @currency=#<Money::Currency id: usd>>
  #   'hello 2000 world'.to_money   #=> #<Money @fractional=200000 @currency=#<Money::Currency id: usd>>
  #
  # @see Money.from_string
  #
  def to_money(currency = nil)
    Money.parse(self, currency)
  end

  # Converts the current string into a +Currency+ object.
  #
  # @return [Money::Currency]
  #
  # @raise [Money::Currency::UnknownCurrency]
  #   If this String reference an unknown currency.
  #
  # @example
  #   "USD".to_currency #=> #<Money::Currency id: usd>
  #
  def to_currency
    Money::Currency.new(self)
  end

end

# Open +Symbol+ to add new methods.
class Symbol

  # Converts the current symbol into a +Currency+ object.
  #
  # @return [Money::Currency]
  #
  # @raise [Money::Currency::UnknownCurrency]
  #   If this String reference an unknown currency.
  #
  # @example
  #   :ars.to_currency #=> #<Money::Currency id: ars>
  #
  def to_currency
    Money::Currency.new(self)
  end

end
