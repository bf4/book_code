#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
if ENV['SIMULATE_JRUBY']
  original_ruby_platform = RUBY_PLATFORM
  Object.send(:remove_const, :RUBY_PLATFORM)
  RUBY_PLATFORM = 'java'
end

RSpec.configure do |config|
  config.filter_run_excluding :jruby_only unless RUBY_PLATFORM == 'java'
end

if ENV['SIMULATE_JRUBY']
  Object.send(:remove_const, :RUBY_PLATFORM)
  RUBY_PLATFORM = original_ruby_platform
end

RSpec.describe "All rubies" do
  it "always runs" do
  end
end

RSpec.describe "Only on JRuby", :jruby_only do
  it "always runs" do
  end
end
