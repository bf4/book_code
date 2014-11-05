#---
# Excerpted from "Deploying with JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jkdepj for more book information.
#---
java_import "javax.management.ObjectName"
java_import "java.lang.management.ManagementFactory"

mbean = LoggingBean.new
object_name = ObjectName.new("twitalytics:name=LoggingBean")

mbean_server = ManagementFactory.platform_mbean_server
mbean_server.register_mbean mbean, object_name
