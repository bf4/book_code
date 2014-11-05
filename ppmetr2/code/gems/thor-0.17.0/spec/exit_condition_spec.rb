#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'thor/base'

describe "Exit conditions" do
  it "exits 0, not bubble up EPIPE, if EPIPE is raised" do
    epiped = false

    task = Class.new(Thor) do
      desc "my_action", "testing EPIPE"
      define_method :my_action do
        epiped = true
        raise Errno::EPIPE
      end
    end

    expect{ task.start(["my_action"]) }.to raise_error(SystemExit)
    expect(epiped).to eq(true)
  end
end
