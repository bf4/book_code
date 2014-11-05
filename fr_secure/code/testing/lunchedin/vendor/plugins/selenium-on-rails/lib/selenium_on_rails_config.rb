#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require 'yaml'
require 'erb'

class SeleniumOnRailsConfig
  @@defaults = {:environments => ['test']}
  def self.get var, default = nil
    value = configs[var.to_s]
    value ||= @@defaults[var]
    value ||= default
    value ||= yield if block_given?
    value
  end

  private
    def self.configs
      @@configs ||= nil
      unless @@configs
        files = [File.join(RAILS_ROOT, 'config', 'selenium.yml'), File.expand_path(File.dirname(__FILE__) + '/../config.yml')]
        files.each do |file|
          if File.exist?(file)
            @@configs = YAML.load(ERB.new(IO.read(file)).result)
            break
          end
        end
        @@configs ||= {}
      end
      @@configs
    end

end
