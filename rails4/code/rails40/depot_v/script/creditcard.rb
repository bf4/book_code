#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
credit_card = ActiveMerchant::Billing::CreditCard.new(
  number:     '4111111111111111',
  month:      '8',
  year:       '2009',
  first_name: 'Tobias',
  last_name:  'Luetke',
  verification_value:  '123' 
)

puts "Is #{credit_card.number} valid?  #{credit_card.valid?}"
