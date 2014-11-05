#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
require 'java'
require 'jemmy.jar'

$CLASSPATH << '.'
include_class 'org.crocodile.timecalc.TimeCalcApp'
include_class 'org.netbeans.jemmy.JemmyProperties'
include_class 'org.netbeans.jemmy.TestOut'

%w(Frame Label Button).each do |o|
  include_class "org.netbeans.jemmy.operators.#{o}Operator"
end

JemmyProperties.set_current_timeout 'DialogWaiter.WaitFrameTimeout', 3000
JemmyProperties.set_current_output TestOut.get_null_output

class Calculator
  def initialize
    TimeCalcApp.main nil

    @main_window = FrameOperator.new 'Time Calc'
    @result = LabelOperator.new @main_window

    keys = (0..9).to_a + [:days, :hours,
                          :minutes, :seconds,
                          :help, :off,
                          '+', '-', '*', '/',
                          '=', 'C']

    @buttons = {}
    keys.each do |k|
      @buttons[k] = ButtonOperator.new @main_window, k.to_s.capitalize
    end
  end

  def clear
    @buttons['C'].push
  end

  def plus
    @buttons['+'].push
  end

  def equals
    @buttons['='].push
    sleep 0.5
  end

  def off
    @buttons[:off].push
  end

  def enter_number(number)
    number.to_i.to_s.split(//).each do |n|
      @buttons[n.to_i].push
    end
  end

  def enter_time(days, hours, minutes, seconds)
    numbers = [days, hours, minutes, seconds]
    units = [:days, :hours, :minutes, :seconds]
    skip = true

    numbers.each_with_index do |number, index|
      skip &&= (0 == number &&
                :seconds != units[index])

      unless skip
        enter_number(number)
        @buttons[units[index]].push
      end
    end
  end

  def time
    result = {}

    text = @result.text
    text.scan(/[0-9]+[dhms]/).collect do |part|
      number = part.to_i
      units = part[-1..-1]
      result[units] = number
    end

    ['d', 'h', 'm', 's'].map {|u| result[u] || 0}
  end

  def total_seconds
    multipliers = [86400, 3600, 60, 1]
    time.zip(multipliers).inject(0) do |total, part|
      total + part[0] * part[1]
    end
  end

  def self.single
    @@single ||= Calculator.new
  end
end

if __FILE__ == $0
  Calculator.new
end
