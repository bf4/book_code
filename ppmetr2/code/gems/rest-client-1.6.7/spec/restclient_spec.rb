#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require File.join( File.dirname(File.expand_path(__FILE__)), 'base')

describe RestClient do
  describe "API" do
    it "GET" do
      RestClient::Request.should_receive(:execute).with(:method => :get, :url => 'http://some/resource', :headers => {})
      RestClient.get('http://some/resource')
    end

    it "POST" do
      RestClient::Request.should_receive(:execute).with(:method => :post, :url => 'http://some/resource', :payload => 'payload', :headers => {})
      RestClient.post('http://some/resource', 'payload')
    end

    it "PUT" do
      RestClient::Request.should_receive(:execute).with(:method => :put, :url => 'http://some/resource', :payload => 'payload', :headers => {})
      RestClient.put('http://some/resource', 'payload')
    end

    it "PATCH" do
      RestClient::Request.should_receive(:execute).with(:method => :patch, :url => 'http://some/resource', :payload => 'payload', :headers => {})
      RestClient.patch('http://some/resource', 'payload')
    end

    it "DELETE" do
      RestClient::Request.should_receive(:execute).with(:method => :delete, :url => 'http://some/resource', :headers => {})
      RestClient.delete('http://some/resource')
    end

    it "HEAD" do
      RestClient::Request.should_receive(:execute).with(:method => :head, :url => 'http://some/resource', :headers => {})
      RestClient.head('http://some/resource')
    end

    it "OPTIONS" do
      RestClient::Request.should_receive(:execute).with(:method => :options, :url => 'http://some/resource', :headers => {})
      RestClient.options('http://some/resource')
    end
  end

  describe "logging" do
    after do
      RestClient.log = nil
    end

    it "uses << if the log is not a string" do
      log = RestClient.log = []
      log.should_receive(:<<).with('xyz')
      RestClient.log << 'xyz'
    end

    it "displays the log to stdout" do
      RestClient.log = 'stdout'
      STDOUT.should_receive(:puts).with('xyz')
      RestClient.log << 'xyz'
    end

    it "displays the log to stderr" do
      RestClient.log = 'stderr'
      STDERR.should_receive(:puts).with('xyz')
      RestClient.log << 'xyz'
    end

    it "append the log to the requested filename" do
      RestClient.log = '/tmp/restclient.log'
      f = mock('file handle')
      File.should_receive(:open).with('/tmp/restclient.log', 'a').and_yield(f)
      f.should_receive(:puts).with('xyz')
      RestClient.log << 'xyz'
    end
  end

end
