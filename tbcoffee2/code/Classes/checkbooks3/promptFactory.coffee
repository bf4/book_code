utils = require('./utils')

# PromptFactory defines the presentation of each prompt in the app

class PromptFactory
  constructor: ({@allAccounts}) ->

  accountPrompt: ->
    {
      name: 'account'
      message: 'Pick an account:'
      type: 'list'
      choices: (for account in @allAccounts
        {name: account.description(), value: account}
      ).concat({name: 'new account', value: null})
    }

  newAccountPrompt: ->
    {
      name: 'name'
      message: 'Enter a name for this account:'
      type: 'input'
      validate: (input) ->
        for account in @allAccounts
          if account.name is input
            return 'That account name is already taken!'
        true
    }

  actionPrompt: ({account}) ->
    {
      name: 'action'
      message: 'Pick an action:'
      type: 'list'
      choices: [
        {name: 'deposit', 'Deposit $ into this account'}
        {name: 'withdraw', 'Withdraw $ from this account'}
        {name: 'transfer', 'Transfer $ to another account'}
      ]
    }

  toAccountPrompt: ({fromAccount}) ->
    {
      name: 'toAccount'
      message: 'Pick an account to transfer $ to:'
      type: 'list'
      choices: for account in @allAccounts when account isnt fromAccount
        {name: account.description(), value: account}
    }

  amountPrompt: ({action}) ->
    {
      name: 'amount'
      message: "Enter the amount to #{action}:"
      type: 'input'
      validate: (input) ->
        if isNaN(utils.inputToNumber(input))
          return 'Please enter a numerical amount.'
        if utils.inputToNumber(input) < 0
          return 'Please enter a non-negative amount.'
        true
    }

module.exports = PromptFactory
