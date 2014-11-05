#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveSupport
  if RUBY_VERSION >= '1.9'
    FrozenObjectError = RuntimeError
  else
    FrozenObjectError = TypeError
  end
end

# TODO: Turn all this into using the BacktraceCleaner.
class Exception # :nodoc:
  def clean_message
    Pathname.clean_within message
  end

  TraceSubstitutions = []
  FrameworkStart = /action_controller\/dispatcher\.rb/.freeze
  FrameworkRegexp = /generated|vendor|dispatch|ruby|script\/\w+/.freeze

  def clean_backtrace
    backtrace.collect do |line|
      Pathname.clean_within(TraceSubstitutions.inject(line) do |result, (regexp, sub)|
        result.gsub regexp, sub
      end)
    end
  end

  def application_backtrace
    before_framework_frame = nil
    before_application_frame = true

    trace = clean_backtrace.reject do |line|
      before_framework_frame ||= (line =~ FrameworkStart)
      non_app_frame = (line =~ FrameworkRegexp)
      before_application_frame = false unless non_app_frame
      before_framework_frame || (non_app_frame && !before_application_frame)
    end

    # If we didn't find any application frames, return an empty app trace.
    before_application_frame ? [] : trace
  end

  def framework_backtrace
    clean_backtrace.grep FrameworkRegexp
  end
end
