#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
# Load the spec so we get access to `RecordResult` struct.
# rubocop:disable Lint/DuplicateMethods
require 'rspec/core'
require_relative 'spec/unit/app/api_spec.rb'
require 'sinatra/base'

class Ledger
  def record(_expense)
    ExpenseTracker::RecordResult.new
  end
end

class API < Sinatra::Base
  def initialize
    @ledger = Ledger.new
    super() # rest of initialization from Sinatra
  end
end

# Later, callers do this:
app = API.new
app.to_s # avoid unused variable warning

Object.send(:remove_const, :API)

class API < Sinatra::Base
  def initialize(ledger:)
    @ledger = ledger
    super()
  end
end

# Later, callers do this:
app = API.new(ledger: Ledger.new)
app.to_s # avoid unused variable warning

@ledger = Ledger.new

# rubocop:disable Style/BracesAroundHashParameters
# Pseudocode for what happens inside the API class:
#
result = @ledger.record({ 'some' => 'data' })
result.success?      # => a Boolean
result.expense_id    # => a number
result.error_message # => a string or nil
# rubocop:enable Style/BracesAroundHashParameters
# rubocop:enable Lint/DuplicateMethods
