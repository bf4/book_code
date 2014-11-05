#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'spec_helper'

describe Ghee::API::Events do
  subject { Ghee.new(GH_AUTH) }

  EventTypes = ["CommitComment","CreateEvent","DeleteEvent","DownloadEvent","FollowEvent",
  "ForkEvent","ForkApplyEvent","GistEvent","GollumEvent","IssueCommentEvent",
  "IssuesEvent","MemberEvent","PublicEvent","PullRequestEvent","PushEvent",
  "TeamAddEvent","WatchEvent"]

  def should_be_an_event(event)
    EventTypes.should include(event['type'])
    event['repo'].should be_instance_of(Hashie::Mash)
    event['actor'].should be_instance_of(Hashie::Mash)
    event['created_at'].should_not be_nil
  end

  describe "#events" do
    it "should return public events" do
      VCR.use_cassette('events') do
        events = subject.events
        events.size.should > 0
        should_be_an_event(events.first)
      end
    end
    describe "#paginate" do 
      it "should return page 1" do
        VCR.use_cassette "events.page1" do
          events = subject.events.paginate :page => 1
          events.size.should > 0
          events.next_page.should == 2
          should_be_an_event(events.first)
        end
      end
      it "should return page 2" do
        VCR.use_cassette "events.page2" do
          events = subject.events.paginate :page => 2
          events.size.should > 0
          events.next_page.should == 3
          events.prev_page.should == 1
          should_be_an_event(events.first)
        end
      end
    end
  end
end
