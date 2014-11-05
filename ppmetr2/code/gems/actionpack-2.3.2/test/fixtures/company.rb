#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Company < ActiveRecord::Base
  has_one :mascot
  attr_protected :rating
  set_sequence_name :companies_nonstd_seq

  validates_presence_of :name
  def validate
    errors.add('rating', 'rating should not be 2') if rating == 2
  end  
end