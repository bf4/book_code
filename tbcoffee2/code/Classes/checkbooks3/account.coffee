jsonfile = require('jsonfile')

utils = require('./utils')

# Account implements all actions that affect data

class Account
  constructor: ({@name, @balance}) ->
    Account.allAccounts.push @
    return

  description: ->
    "#{@name}: #{utils.dollarsToString(@balance)}"

  deposit: ({amount}) ->
    @balance += amount
    Account.saveState()
    @

  withdraw: ({amount}) ->
    @balance -= amount
    Account.saveState()
    @

  transfer: ({toAccount, amount}) ->
    @balance -= amount
    toAccount.balance += amount
    Account.saveState()
    @

  @allAccounts = []

  @saveState: ->
    jsonfile.writeFileSync('./data.json', Account.allAccounts)

  @loadState: ->
    try
      Account.allAccounts = for accountData in jsonfile.readFileSync('./data.json')
        new Account(accountData)
    catch e
      Account.allAccounts = [
        new Account({balance: 0, name: 'checking'})
        new Account({balance: 0, name: 'savings'})
        new Account({balance: 0, name: 'mattress'})
      ]
    return

module.exports = Account
