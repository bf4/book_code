#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
# validate me
require 'rspec/core'
require 'stringio'

$spec_out = StringIO.new
$spec_err = StringIO.new
RSpec.configuration.output_stream = $spec_out
RSpec.configuration.error_stream  = $spec_err

class SwissArmyKnife; end

# Old syntax

describe SwissArmyKnife do  # bare `describe` method
  it 'is useful' do
    knife.should be_useful  # `should` expectation
  end
end

# rubocop:disable Style/SymbolProc
RSpec.configure do |config|
  config.disable_monkey_patching!
end
# rubocop:enable Style/SymbolProc

# New syntax

RSpec.describe SwissArmyKnife do  # `describe` called on the `RSpec` module
  it 'is useful' do
    expect(knife).to be_useful    # `expect()`-style expectation
  end
end

RSpec.configure do |config|
  config.order = :random
end

RSpec.configure do |config|
  config.add_setting :spec_history_api_key
end

RSpec.configure do |config|
  config.spec_history_api_key = 'a762bc901fga4b185b'
end
