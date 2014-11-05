#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'git'

class Git::Diff::DiffFile
  include Java::book.embed.GitDiff
end

class Archive
  def history(revisions)
    git = Git.open '.'
    git.diff(revisions.start, revisions.finish).to_a
  end
end
