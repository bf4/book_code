#---
# Excerpted from "Working with Unix Processes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsunix for more book information.
#---
module Spyglass
  class Configurator
    # A hash of key => default
    OPTIONS = {
      :port => 4222,
      :host => '0.0.0.0',
      :workers => 2,
      :timeout => 30,
      :config_ru_path => 'config.ru',
      :verbose => false,
      :vverbose => false
    }
    
    class << self
      OPTIONS.each do |key, default|
        # attr_writer key
      
        define_method(key) do |*args|
          arg = args.shift
          if arg
            instance_variable_set("@#{key}", arg)
          else
            instance_variable_get("@#{key}") || default
          end
        end
      end
    end
  end
  
  Config = Configurator
end
