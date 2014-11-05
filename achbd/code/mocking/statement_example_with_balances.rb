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
    "Statement for #{@customer.name}\nAccount no. #{@customer.account_number}\nBalance due:\n30 days: #{@customer.due(30)}\n60 days: #{@customer.due(60)}"
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
  it "uses the customer's balances in the footer" do
    customer = stub().as_null_object
    customer.stub(:due) {|days| "#{days}.00"} 
    statement = Statement.new(customer)
    statement.generate.should =~ /30 days: 30.00/i
    statement.generate.should =~ /60 days: 60.00/i
  end
end
