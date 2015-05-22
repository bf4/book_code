#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
require "benchmark"

Benchmark.bm do |bm|
  bm.report do
    open("| sort | uniq -c | sort -rn | head -n 10", "w") do |sort|
      open("data/error_log") do |log|
        log.each_line do |line|
          if line =~ /^\[.+\] \[error\] (.*)$/
            sort.puts $1
          end
        end
      end
    end
  end

  bm.report do
    errors = Hash.new(0)

    open("data/error_log") do |log|
      log.each_line do |line|
        if line =~ /^\[.+\] \[error\] (.*)$/
          errors[$1] += 1
        end
      end
    end

    errors = errors.sort_by { |_, n| n }.reverse

    errors.first(10).each do |error, n|
      puts "#{n} #{error}"
    end
  end
end

