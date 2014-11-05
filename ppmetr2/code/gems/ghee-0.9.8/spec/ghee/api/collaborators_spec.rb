#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'spec_helper'

describe Ghee::API::Repos::Collaborators do
  subject { Ghee.new(GH_AUTH).repos(GH_USER, GH_REPO) }
  
  describe "#collaborators" do

    # dont have a good way to test the collaborators api
    it "should have a collaborators method" do
      subject.respond_to?("collaborators").should be_true
    end

  end
  describe "#assignees" do
    it "should have at least one assignee" do
      VCR.use_cassette "#repos#assignees" do
        subject.assignees.size.should > 0
      end
    end
    it "current user should be an assignee" do
      VCR.use_cassette "#repos#assignees#check" do
        subject.assignees.check?(GH_USER).should be_true
      end

    end
  end
end
