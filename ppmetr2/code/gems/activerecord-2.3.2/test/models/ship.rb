#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Ship < ActiveRecord::Base
  self.record_timestamps = false

  belongs_to :pirate
  has_many :parts, :class_name => 'ShipPart', :autosave => true

  accepts_nested_attributes_for :pirate, :allow_destroy => true, :reject_if => proc { |attributes| attributes.empty? }

  validates_presence_of :name
end
