#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---

require 'test/unit'
require 'test/unit/collector'
require 'test/unit/ui/testrunnermediator'

require 'java'
java_import 'junit.framework.TestCase'
java_import 'junit.framework.AssertionFailedError'

class RubyTest < TestCase
  def countTestCases; 1; end
  def run(result); end
  def toString; name; end
end

class TestUnitClassCollector
  include Test::Unit::Collector

  def collect(name, klasses)
    suite = Test::Unit::TestSuite.new(name)
    sub_suites = []
    klasses.each do |klass|
      add_suite(sub_suites, klass.suite)
    end
    sort(sub_suites).each{|s| suite << s}
    suite
  end
end

class TestUnitResultHandler
  def self.run(suite, ignored=nil)
    runner = new suite
    runner.instance_variable_set :@result_handler, @result_handler
    runner.start
  end

  def initialize(suite, io=STDOUT)
    if suite.respond_to? :suite
      @suite = suite.suite
    else
      @suite = suite
    end
  end

  def start
    @mediator = Test::Unit::UI::TestRunnerMediator.new @suite

    @mediator.add_listener Test::Unit::TestResult::FAULT,
                           &method(:add_fault)
    @mediator.add_listener Test::Unit::TestCase::STARTED,
                           &method(:test_started)
    @mediator.add_listener Test::Unit::TestCase::FINISHED,
                           &method(:test_finished)

    @mediator.run_suite
  end
end

class TestUnitResultHandler
  private

  def add_fault(fault)
    case fault.single_character_display
    when 'F': @result_handler.add_failure(@current_test,
                                          AssertionFailedError.new(fault.to_s))
    when 'E': @result_handler.add_error(@current_test,
                                        java.lang.Throwable.new(fault.to_s))
    end
  end

  def test_started(name)
    @current_test = RubyTest.new(name)
    @result_handler.start_test(@current_test)
  end

  def test_finished(name)
    @result_handler.end_test(@current_test)
  end
end

class JUnitAdapter
  def initialize(test_result)
    @test_result = test_result
  end

  def run_tests
    Dir["test/**/*_test.rb"].each do |f|
      load f
    end

    Test::Unit::AutoRunner.new(false) do |runner|
      runner.collector = collect_all_test_unit_classes
      runner.runner    = report_results_to_junit
    end.run
  end
end

class JUnitAdapter
  private

  def collect_all_test_unit_classes
    proc do |runner|
      c = TestUnitClassCollector.new
      c.filter = runner.filters
      c.collect("Tests", test_unit_classes)
    end
  end

  def report_results_to_junit
    proc do |runner|
      TestUnitResultHandler.instance_variable_set :@result_handler, @test_result
      TestUnitResultHandler
    end
  end

  def test_unit_classes
    all = []
    ObjectSpace.each_object(Class) do |klass|
      if Test::Unit::TestCase > klass
        all << klass
      end
    end
    all
  end
end
