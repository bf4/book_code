#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Parrot < ActiveRecord::Base
  set_inheritance_column :parrot_sti_class
  has_and_belongs_to_many :pirates
  has_and_belongs_to_many :treasures
  has_many :loots, :as => :looter
  alias_attribute :title, :name

  validates_presence_of :name
end

class LiveParrot < Parrot
end

class DeadParrot < Parrot
  belongs_to :killer, :class_name => 'Pirate'
end
