#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
require "benchmark/ips"

def get_week(file, week)
  file.seek((week - 1) * 63)

  week = {
    date:  file.read(10).strip,
    temps: {}
  }

  [:nino12, :nino3, :nino34, :nino4].each do |region|
    week[:temps][region] = {
      temp: file.read(9).to_f,
      change: file.read(4).to_f
    }
  end

  week
end

File.open("data/wksst8110.for") do |file|
  Benchmark.ips do |x|
    x.report("3") { get_week(file, 3) }
    x.report("303") { get_week(file, 303) }
    x.report("1003") { get_week(file, 1003) }

    x.compare!
  end
end

