#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
class Output
  def messages
    @messages ||= []
  end

  def puts(message)
    messages << message
  end
end

def output
  @output ||= Output.new
end

Given /^I am not yet playing$/ do
end

Given /^the secret code is "([^"]*)"$/ do |secret|
  @game = Codebreaker::Game.new(output)
  @game.start(secret)
end

When /^I start a new game$/ do
  game = Codebreaker::Game.new(output)
  game.start('1234')
end

When /^I guess "([^"]*)"$/ do |guess|
  @game.guess(guess)
end

Then /^I should see "([^"]*)"$/ do |message|
  output.messages.should include(message)
end

Then /^the mark should be "([^"]*)"$/ do |mark|
  output.messages.should include(mark)
end

