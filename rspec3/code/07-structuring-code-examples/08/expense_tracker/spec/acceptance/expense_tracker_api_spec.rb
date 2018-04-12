#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'rack/test'
require 'json'
require_relative '../../app/api'

module ExpenseTracker
  module APIHelpers
    include Rack::Test::Methods

    def app
      ExpenseTracker::API.new
    end
  end

  RSpec.configure do |config|
    config.include APIHelpers
  end


  RSpec.describe 'Expense Tracker API', :db do
    include APIHelpers

    def post_expense(expense)
      post '/expenses', JSON.generate(expense)
      expect(last_response.status).to eq(200)

      parsed = JSON.parse(last_response.body)
      expect(parsed).to include('expense_id' => a_kind_of(Integer))
      expense.merge('id' => parsed['expense_id'])
    end

    it 'records submitted expenses' do
      coffee = post_expense(
        'payee'  => 'Starbucks',
        'amount' => 5.75,
        'date'   => '2017-06-10'
      )

      zoo = post_expense(
        'payee'  => 'Zoo',
        'amount' => 15.25,
        'date'   => '2017-06-10'
      )

      groceries = post_expense(
        'payee'  => 'Whole Foods',
        'amount' => 95.20,
        'date'   => '2017-06-11'
      )

      get '/expenses/2017-06-10'
      expect(last_response.status).to eq(200)

      expenses = JSON.parse(last_response.body)
      expect(expenses).to contain_exactly(coffee, zoo)
    end

    # ...
  end
end
