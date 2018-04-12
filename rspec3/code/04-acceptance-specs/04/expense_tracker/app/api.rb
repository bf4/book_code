#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'sinatra/base'
require 'json'

module ExpenseTracker
  class API < Sinatra::Base
    post '/expenses' do
      JSON.generate('expense_id' => 42)
    end
  end
end
