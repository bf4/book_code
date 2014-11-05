#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
require 'calculator'

$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'rubygems'
require 'fit/parse'
require 'fit/file_runner'

report = ARGV[1]
unless report.nil?
  Fit::Parse.footnote_path = File.dirname(report) + File::SEPARATOR
end

class CalcRunner < Fit::FileRunner
  def run(args)
    process_args args
    process
    $stderr.puts @fixture.totals
    Calculator.single.off # will exit
  end
end

CalcRunner.new.run(ARGV)
