#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require "cases/helper"
require 'models/owner'
require 'models/pet'

class ReloadModelsTest < ActiveRecord::TestCase
  fixtures :pets

  def test_has_one_with_reload
    pet = Pet.find_by_name('parrot')
    pet.owner = Owner.find_by_name('ashley')

    # Reload the class Owner, simulating auto-reloading of model classes in a
    # development environment. Note that meanwhile the class Pet is not
    # reloaded, simulating a class that is present in a plugin.
    Object.class_eval { remove_const :Owner }
    Kernel.load(File.expand_path(File.join(File.dirname(__FILE__), "../models/owner.rb")))

    pet = Pet.find_by_name('parrot')
    pet.owner = Owner.find_by_name('ashley')
    assert_equal pet.owner, Owner.find_by_name('ashley')
  end
end
