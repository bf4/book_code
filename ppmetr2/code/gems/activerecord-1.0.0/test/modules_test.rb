#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'abstract_unit'
# require File.dirname(__FILE__) + '/../dev-utils/eval_debugger'
require 'fixtures/company_in_module'

class ModulesTest < Test::Unit::TestCase
  def setup
    create_fixtures "accounts"
    create_fixtures "companies"
  end

  def test_module_spanning_associations
    assert MyApplication::Business::Firm.find_first.has_clients?, "Firm should have clients"
    firm = MyApplication::Business::Firm.find_first
    assert_nil firm.class.table_name.match('::'), "Firm shouldn't have the module appear in its table name"
    assert_equal 2, firm.clients_count, "Firm should have two clients"
  end
  
  def test_associations_spanning_cross_modules
    assert MyApplication::Billing::Account.find(1).has_firm?, "37signals account should be able to backtrack"
  end
end