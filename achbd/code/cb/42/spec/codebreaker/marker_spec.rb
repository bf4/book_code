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
  describe Marker do
    describe "#exact_match_count" do
      context "with no matches" do
        it "returns 0" do
          marker = Marker.new('1234','5555')
          marker.exact_match_count.should == 0
        end
      end
      
      context "with 1 exact match" do
        it "returns 1" do
          marker = Marker.new('1234','1555')
          marker.exact_match_count.should == 1
        end
      end
      
      context "with 1 number match" do
        it "returns 0" do
          marker = Marker.new('1234','2555')
          marker.exact_match_count.should == 0
        end
      end      
      context "with 1 exact match and 1 number match" do
        it "returns 1" do
          marker = Marker.new('1234','1525')
          marker.exact_match_count.should == 1
        end
      end
    end

    describe "#number_match_count" do
      context "with no matches" do
        it "returns 0" do
          marker = Marker.new('1234','5555')
          marker.number_match_count.should == 0
        end
      end

      context "with 1 number match" do
        it "returns 1" do
          marker = Marker.new('1234','2555')
          marker.number_match_count.should == 1
        end
      end
      
      context "with 1 exact match" do
        it "returns 0" do
          marker = Marker.new('1234','1555')
          marker.number_match_count.should == 0
        end
      end
      
      context "with 1 exact match and 1 number match" do
        it "returns 1" do
          marker = Marker.new('1234','1525')
          marker.number_match_count.should == 1
        end
      end
    end
  end
end
