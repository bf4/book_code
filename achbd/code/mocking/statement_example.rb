#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
class Statement
  def initialize(customer)
    @customer = customer
  end
  def generate
    "Statement for #{@customer.name}" 
  end
end

class Statement
  def initialize(customer)
    @customer = customer
  end
  
  def generate
    "Statement for Aslak" 
  end
end


class Statement
  def initialize(customer, logger = nil)
    @customer = customer
    @logger = logger
  end
  
  def generate
    name = @customer.name
    @logger.log("Statement generated for #{name}") if @logger
    "Statement for #{name}"
  end
end

class CustomerDouble
  def name
    "Dave Astels"
  end
end

describe Statement do
  it "uses the customer's name in the header" do
    statement = Statement.new(CustomerDouble.new)
    statement.generate.should =~ /^Statement for Dave Astels/
  end
end

class ProgrammableCustomerDouble
  def initialize(options={})
    @name = options[:name]
  end
  def name
    @name
  end
end

describe Statement do
  it "uses the customer's name in the header" do
    customer = ProgrammableCustomerDouble.new(:name => 'Aslak')
    statement = Statement.new(customer)
    statement.generate.should =~ /^Statement for Aslak/
  end
end

describe Statement do
  it "uses the customer's name in the header" do
    customer = double('customer')             
    customer.stub(:name).and_return('Aslak')  
    statement = Statement.new(customer)
    statement.generate.should =~ /^Statement for Aslak/ 
  end
end

describe Statement do
  it "uses the customer's name in the header" do
    customer = double('customer')
    customer.should_receive(:name).and_return('Aslak')
    statement = Statement.new(customer)
    statement.generate.should =~ /^Statement for Aslak/
  end
end

describe Statement do
  it "uses the customer's name in the header" do
    customer = double('customer', :name => 'Aslak')   
    statement = Statement.new(customer)
    statement.generate.should =~ /^Statement for Aslak/
  end
end


describe Statement do
  it "uses the customer's name in the header" do
    customer = double('customer')
    customer.stub(:name).and_return('Aslak')
    logger   = double('logger')
    logger.stub(:log)
    statement = Statement.new(customer, logger)
    statement.generate.should =~ /^Statement for Aslak/
  end

  it "logs a message on generate()" do
    customer = stub('customer')
    customer.stub(:name).and_return('Aslak')
    logger   = mock('logger')
    statement = Statement.new(customer, logger)
    logger.should_receive(:log).with(/Statement generated for Aslak/)
    statement.generate
  end
end

describe Statement do
  before(:each) do
    @customer = double('customer')
    @logger   = double('log', :log => nil)
    @statement = Statement.new(@customer, @logger)
  end
  
  it "uses the customer's name in the header" do
    @customer.should_receive(:name).and_return('Aslak')
    @statement.generate.should =~ /^Statement for Aslak/
  end

  it "logs a message on generate()" do
    @customer.stub(:name).and_return('Aslak')
    @logger.should_receive(:log).with(/Statement generated for Aslak/)
    @statement.generate
  end
end
