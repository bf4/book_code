#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
$:.unshift(File.dirname(__FILE__) + "/../lib")

require "action_controller"
require 'action_controller/test_process'

Person = Struct.new("Person", :name, :address, :age)

class BenchmarkController < ActionController::Base
  def message
    render_text "hello world"
  end

  def list
    @people = [ Person.new("David"), Person.new("Mary") ]
    render_template "hello: <% for person in @people %>Name: <%= person.name %><% end %>"
  end
  
  def form_helper
    @person = Person.new "david", "hyacintvej", 24
    render_template(
      "<% person = Person.new 'Mary', 'hyacintvej', 22 %> " +
      "change the name <%= text_field 'person', 'name' %> and  <%= text_field 'person', 'address' %> and <%= text_field 'person', 'age' %>"
    )
  end
end

#ActionController::Base.template_root = File.dirname(__FILE__)

require "benchmark"

RUNS = ARGV[0] ? ARGV[0].to_i : 50

require "profile" if ARGV[1]

runtime = Benchmark.measure {
  RUNS.times { BenchmarkController.process_test(ActionController::TestRequest.new({ "action" => "list" })) }
}

puts "List: #{RUNS / runtime.real}"


runtime = Benchmark.measure {
  RUNS.times { BenchmarkController.process_test(ActionController::TestRequest.new({ "action" => "message" })) }
}

puts "Message: #{RUNS / runtime.real}"

runtime = Benchmark.measure {
  RUNS.times { BenchmarkController.process_test(ActionController::TestRequest.new({ "action" => "form_helper" })) }
}

puts "Form helper: #{RUNS / runtime.real}"
