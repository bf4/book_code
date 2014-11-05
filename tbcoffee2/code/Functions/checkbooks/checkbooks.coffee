createAccount = (name) ->
  {
    name: name
    balance: 0

    description: ->
      "#{@name}: #{dollarsToString(@balance)}"

    deposit: (amount) ->
      @balance += amount
      @

    withdraw: (amount) ->
      @balance -= amount
      @
  }

checking = createAccount('Checking')
savings  = createAccount('Savings')
mattress = createAccount('Mattress')

inquirer = require('inquirer')

promptForAccount = ->
  inquirer.prompt({
    name: 'account'
    message: 'Pick an account:'
    type: 'list'
    choices: [
      {name: checking.description(), value: checking}
      {name: savings.description(), value: savings}
      {name: mattress.description(), value: mattress}
    ]
  }, (answers) ->
    account = answers.account
    promptForAction(account)
  )

promptForAction = (account) ->
  inquirer.prompt({
    name: 'action'
    message: 'Pick an action:'
    type: 'list'
    choices: [
      {name: 'deposit', 'Deposit $ into this account'}
      {name: 'withdraw', 'Withdraw $ from this account'}
    ]
  }, (answers) ->
    action = answers.action
    promptForAmount(account, action)
  )

promptForAmount = (account, action) ->
  inquirer.prompt({
    name: 'amount'
    message: "Enter the amount to #{action}:"
    type: 'input'
    validate: (input) ->
      if isNaN(inputToNumber(input))
        return 'Please enter a numerical amount.'
      if inputToNumber(input) < 0
        return 'Please enter a non-negative amount.'
      true
  }, (answers) ->
    amount = inputToNumber(answers.amount)
    account[action](amount)
    promptForAccount()
  )

numeral = require ('numeral')

dollarsToString = (dollars) ->
  numeral(dollars).format('$0,0.00')

inputToNumber = (input) ->
  parseFloat input.replace(/[$,]/g, ''), 10

promptForAccount()
