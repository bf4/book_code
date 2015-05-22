#---
# Excerpted from "Ruby Performance Optimization",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/adrpo for more book information.
#---
require 'minitest/autorun'

class Minitest::Test

  def assert_performance(current_performance)
    self.assertions += 1  # increase Minitest assertion counter

    benchmark_name, current_average, current_stddev = *current_performance
    past_average, past_stddev = load_benchmark(benchmark_name)
    save_benchmark(benchmark_name, current_average, current_stddev)

    optimization_mean, optimization_standard_error = compare_performance(
      past_average, past_stddev, current_average, current_stddev
    )

    optimization_confidence_interval = [
      optimization_mean - 2*optimization_standard_error,
      optimization_mean + 2*optimization_standard_error
    ]

    conclusion = if optimization_confidence_interval.all? { |i| i < 0 }
      :slowdown
    elsif optimization_confidence_interval.all? { |i| i > 0 }
      :speedup
    else
      :unchanged
    end

    print "%-28s %0.3f ± %0.3f: %-10s" %
      [benchmark_name, current_average, current_stddev, conclusion]
    if conclusion != :unchanged
      print " by %0.3f..%0.3f with 95%% confidence" %
        optimization_confidence_interval
    end
    print "\n"

    if conclusion == :slowdown
      raise MiniTest::Assertion.new("#{benchmark_name} got slower")
    end
  end

private

  def load_benchmark(benchmark_name)
    return [nil, nil] unless File.exist?("benchmarks/#{benchmark_name}")
    File.read("benchmarks/#{benchmark_name}").split(" ").map { |value| value.to_f }
  end

  def save_benchmark(benchmark_name, current_average, current_stddev)
    File.open("benchmarks/#{benchmark_name}", "w+") do |f|
      f.write "%0.3f %0.3f" % [current_average, current_stddev]
    end
  end

  def compare_performance(past_average, past_stddev,
                          current_average, current_stddev)
    # when there's no past data, just report no performance change
    past_average ||= current_average
    past_stddev ||= current_stddev

    optimization_mean = past_average - current_average
    optimization_standard_error = (current_stddev**2/30 + past_stddev**2/30)**0.5

    # drop insignificant digits that our calculations might introduce
    optimization_mean = optimization_mean.round(3)
    optimization_standard_error = optimization_standard_error.round(3)

    [optimization_mean, optimization_standard_error]
  end

end
