#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# The following classes used to be in the top level namespace.
# Loading this file enables compatibility with older Rakefile that
# referenced Task from the top level.

warn "WARNING: Classic namespaces are deprecated and will be removed from future versions of Rake."
# :stopdoc:
Task = Rake::Task
FileTask = Rake::FileTask
FileCreationTask = Rake::FileCreationTask
# ...
RakeApp = Rake::Application
# :startdoc:
