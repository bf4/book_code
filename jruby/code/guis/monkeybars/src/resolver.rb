#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
module Monkeybars
  class Resolver
    IN_FILE_SYSTEM = :in_file_system
    IN_JAR_FILE = :in_jar_file
    
    # Returns a const value indicating if the currently executing code is being run from the file system or from within a jar file.
    def self.run_location
      if File.expand_path(__FILE__) =~ /\.jar\!/
        IN_JAR_FILE
      else
        IN_FILE_SYSTEM
      end
    end
  end
end

class Object
  def add_to_classpath(path)
    $CLASSPATH << get_expanded_path(path)
  end
  
  def add_to_load_path(path)
    $LOAD_PATH << get_expanded_path(path)
  end
  
  private
  def get_expanded_path(path)
    resolved_path = File.expand_path(File.dirname(__FILE__) + "/" + path.gsub("\\", "/"))
    resolved_path.gsub!("file:", "") unless resolved_path.index(".jar!")
    resolved_path.gsub!("%20", ' ')
    resolved_path
  end
end
