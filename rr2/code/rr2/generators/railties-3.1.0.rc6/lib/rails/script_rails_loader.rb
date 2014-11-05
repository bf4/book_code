#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'pathname'

module Rails
  module ScriptRailsLoader
    RUBY = File.join(*RbConfig::CONFIG.values_at("bindir", "ruby_install_name")) + RbConfig::CONFIG["EXEEXT"]
    SCRIPT_RAILS = File.join('script', 'rails')

    def self.exec_script_rails!
      cwd = Dir.pwd
      return unless in_rails_application? || in_rails_application_subdirectory?
      exec RUBY, SCRIPT_RAILS, *ARGV if in_rails_application?
      Dir.chdir("..") do
        # Recurse in a chdir block: if the search fails we want to be sure
        # the application is generated in the original working directory.
        exec_script_rails! unless cwd == Dir.pwd
      end
    rescue SystemCallError
      # could not chdir, no problem just return
    end

    def self.in_rails_application?
      File.exists?(SCRIPT_RAILS)
    end

    def self.in_rails_application_subdirectory?(path = Pathname.new(Dir.pwd))
      File.exists?(File.join(path, SCRIPT_RAILS)) || !path.root? && in_rails_application_subdirectory?(path.parent)
    end
  end
end