#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'abstract_unit'
require 'fixtures/company'

class AssociationInheritanceReloadTest < Test::Unit::TestCase
  fixtures :companies

  def test_set_attributes
    assert_equal ["errors.add_on_empty('name', \"can't be empty\")"], Firm.read_inheritable_attribute("validate"), "Second run"
    # ActiveRecord::Base.reset_column_information_and_inheritable_attributes_for_all_subclasses
    remove_subclass_of(ActiveRecord::Base)
    load 'fixtures/company.rb'
    assert_equal ["errors.add_on_empty('name', \"can't be empty\")"], Firm.read_inheritable_attribute("validate"), "Second run"
  end
end