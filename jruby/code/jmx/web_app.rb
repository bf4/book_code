#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'rubygems'
require 'jmx'
require 'rmi'

class HitBean < RubyDynamicMBean
  def initialize(name, desc)
    super name, desc
    @hits = 0
  end

  def hit!
    @hits += 1
  end

  # rest of implementation goes here...
end

class HitBean
  r_attribute :hits, :int, 'Current hit count'

  operation 'Clear the hit count'
  returns :void
  def clear
    @hits = 0
  end
end

port = 9999
url = "service:jmx:rmi:///jndi/rmi://localhost:#{port}/jmxrmi"

registry  = RMIRegistry.new port
server    = JMX::MBeanServer.new
connector = JMX::MBeanServerConnector.new url, server
connector.start

bean      = HitBean.new 'jruby.HitBean', 'Web app hits'
domain    = server.default_domain
server.register_mbean bean, "#{domain}:type=HitBean"

at_exit do
  connector.stop
  registry.stop
end

require 'sinatra'

get '/' do
  bean.hit!
  "We're watching you"
end
