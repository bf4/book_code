#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module Padrino
  ##
  # This module it's used for bootstrap with padrino rake
  # thirdy party tasks, in your gem/plugin/extension you
  # need only do this:
  #
  # @example
  #   Padrino::Tasks.files << yourtask.rb
  #   Padrino::Tasks.files.concat(Dir["/path/to/all/my/tasks/*.rb"])
  #   Padrino::Tasks.files.unshift("yourtask.rb")
  #
  module Tasks

    ##
    # Returns a list of files to handle with padrino rake
    #
    def self.files
      @files ||= []
    end
  end # Tasks
end # Padrino
