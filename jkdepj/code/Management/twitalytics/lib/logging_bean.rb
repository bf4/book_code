#---
# Excerpted from "Deploying with JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jkdepj for more book information.
#---
class LoggingBean < JMX::DynamicMBean
  operation "Set the Rails log level"
  parameter :int, "level", "the new log level"
  returns :string
  def set_log_level(level)
    Rails.logger.level = level
    "Set log level to #{Rails.logger.level}"
  end
end 