#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
# validate me
require 'rspec/expectations'
include RSpec::Matchers

ENME = RSpec::Expectations::ExpectationNotMetError

def self.heredoc_without_markers(heredoc)
  heredoc.chomp.split("\n").reject { |l| l =~ /# (START|END)/ }.join("\n")
end

expect {
  expect([13, 2, 3, 99]).to all be_odd
}.to raise_error(ENME, heredoc_without_markers(<<-EOM))
expected [13, 2, 3, 99] to all be odd

   object at index 1 failed to match:
      expected `2.odd?` to return true, got false
EOM
