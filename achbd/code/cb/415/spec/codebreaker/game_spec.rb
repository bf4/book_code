#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
require 'spec_helper'

module Codebreaker
  describe Game do
    let(:output) { double('output').as_null_object }
    let(:game)   { Game.new(output) }

    describe "#start" do
      it "sends a welcome message" do
        output.should_receive(:puts).with('Welcome to Codebreaker!')
        game.start('1234')
      end

      it "prompts for the first guess" do
        output.should_receive(:puts).with('Enter guess:')
        game.start('1234')
      end
    end

    describe "#guess" do
      context "with no matches" do
        it "sends a mark with ''" do
          game.start('1234')
          output.should_receive(:puts).with('')
          game.guess('5555')
        end
      end

      context "with 1 number match" do
        it "sends a mark with '-'" do
          game.start('1234')
          output.should_receive(:puts).with('-')
          game.guess('2555')
        end
      end

      context "with 1 exact match" do
        it "sends a mark with '+'" do
          game.start('1234')
          output.should_receive(:puts).with('+')
          game.guess('1555')
        end
      end

      context "with 2 number matches" do
        it "sends a mark with '--'" do
          game.start('1234')
          output.should_receive(:puts).with('--')
          game.guess('2355')
        end
      end

      context "with 1 number match and 1 exact match (in that order)" do
        it "sends a mark with '+-'" do
          game.start('1234')
          output.should_receive(:puts).with('+-')
          game.guess('2535')
        end
      end
    end
  end
end
