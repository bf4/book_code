#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module DefaultCurrencyHelper

  def with_default_currency(iso_code)
    original_default = Money.default_currency
    begin
      Money.default_currency = Money::Currency.new(iso_code)
      yield
    ensure                                     
      Money.default_currency = original_default
    end
  end

end