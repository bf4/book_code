#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
class Statement
  def initialize(customer, logger = nil)
    @customer = customer
    @logger = logger
  end
  
  def generate
    @logger.log("Statement generated for #{@customer.name}") if @logger
    "Statement for #{@customer.name}\nAccount no. #{@customer.account_number}"
  end
end

describe Statement do
  it "uses the customer's name in the header" do
    customer = stub(:name => 'Aslak')
    statement = Statement.new(customer)
    statement.generate.should =~ /^Statement for Aslak/
  end

  it "uses the customer's account_number in the footer" do
    customer = stub(:account_number => '12345')
    statement = Statement.new(customer)
    statement.generate.should =~ /Account no. 12345/
  end
end

describe Statement do
  it "uses the customer's name in the header" do
    customer = stub(:name => 'Aslak').as_null_object
    statement = Statement.new(customer)
    statement.generate.should =~ /^Statement for Aslak/
  end

  it "uses the customer's account_number in the footer" do
    customer = stub(:account_number => '12345').as_null_object
    statement = Statement.new(customer)
    statement.generate.should =~ /Account no. 12345/
  end
end
