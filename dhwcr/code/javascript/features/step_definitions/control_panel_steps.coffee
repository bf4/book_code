{strictEqual} = require 'assert'

stepDefinitions = () ->

  @World = require('../support/World').World

  @Given /^the sign is unlit/, (callback) ->
    @controlPanel.deactivateSign()
    callback()

  @When /^I press the button$/, (callback) ->
    @controlPanel.pressButton()
    callback()

  @Then /^the sign should light up with/, (expected, callback) ->
    strictEqual @controlPanel.signMessage(), expected
    callback()


module.exports = stepDefinitions
