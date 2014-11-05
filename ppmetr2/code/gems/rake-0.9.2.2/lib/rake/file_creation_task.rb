#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'rake/file_task'
require 'rake/early_time'

module Rake

  # A FileCreationTask is a file task that when used as a dependency will be
  # needed if and only if the file has not been created.  Once created, it is
  # not re-triggered if any of its dependencies are newer, nor does trigger
  # any rebuilds of tasks that depend on it whenever it is updated.
  #
  class FileCreationTask < FileTask
    # Is this file task needed?  Yes if it doesn't exist.
    def needed?
      ! File.exist?(name)
    end

    # Time stamp for file creation task.  This time stamp is earlier
    # than any other time stamp.
    def timestamp
      Rake::EARLY
    end
  end

end
