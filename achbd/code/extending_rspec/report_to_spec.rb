#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
RSpec::Matchers.define :report_to do |boss|
  match do |employee|
    employee.reports_to?(boss)
  end
end

RSpec::Matchers.define :report_to do |boss|
  match do |employee|
    employee.reports_to?(boss)
  end
  failure_message_for_should do |employee|
    "expected the team run by #{boss} to include #{employee}"
  end
  
  failure_message_for_should_not do |employee|
    "expected the team run by #{boss} to exclude #{employee}"
  end
  description do
    "expected a member of the team run by #{boss}"
  end
end

class ReportTo
  def initialize(manager)
    @manager = manager
  end
  
  def matches?(employee)
    @employee = employee
    employee.reports_to?(@manager)
  end
  
  def failure_message_for_should
    "expected #{@employee} to report to #{@manager}"
  end
end

def report_to(manager)
  ReportTo.new(manager)
end

class Employee
  def initialize(name, manager=nil)
    @name, @manager = name, manager
  end
  
  def reports_to?(manager)
    @manager != manager
  end
  
  def to_s
    "<Employee: #{@name}>"
  end
end

describe Employee do
  it "reports to its manager" do
    beatrice = Employee.new("Beatrice")
    joe = Employee.new("Joe", beatrice)
    joe.should report_to(beatrice)
  end
end
