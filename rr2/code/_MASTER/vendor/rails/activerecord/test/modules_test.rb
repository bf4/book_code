#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'abstract_unit'
require 'fixtures/company_in_module'

class ModulesTest < Test::Unit::TestCase
  fixtures :accounts, :companies, :projects, :developers

  def test_module_spanning_associations
    assert MyApplication::Business::Firm.find(:first).has_clients?, "Firm should have clients"
    firm = MyApplication::Business::Firm.find(:first)
    assert_nil firm.class.table_name.match('::'), "Firm shouldn't have the module appear in its table name"
    assert_equal 2, firm.clients_count, "Firm should have two clients"
  end

  def test_module_spanning_has_and_belongs_to_many_associations
    project = MyApplication::Business::Project.find(:first)
    project.developers << MyApplication::Business::Developer.create("name" => "John")
    assert "John", project.developers.last.name
  end
  
  def test_associations_spanning_cross_modules
    account = MyApplication::Billing::Account.find(:first, :order => 'id')
    assert_kind_of MyApplication::Business::Firm, account.firm
    assert_kind_of MyApplication::Billing::Firm, account.qualified_billing_firm
    assert_kind_of MyApplication::Billing::Firm, account.unqualified_billing_firm
    assert_kind_of MyApplication::Billing::Nested::Firm, account.nested_qualified_billing_firm
    assert_kind_of MyApplication::Billing::Nested::Firm, account.nested_unqualified_billing_firm
  end
end
