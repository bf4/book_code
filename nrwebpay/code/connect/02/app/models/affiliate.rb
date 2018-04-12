#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class Affiliate < ApplicationRecord

  include HasReference

  belongs_to :user

  def self.generate_tag
    generate_reference(length: 5, attribute: :tag)
  end

  def verification_needed?
    verification_needed.size.positive?
  end

  def verification_form_names
    verification_needed.map { |name| convert_form_name(name) }
  end

  def convert_form_name(attribute)
    "account[#{attribute.gsub('.', '][')}]"
  end

end
