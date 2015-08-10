#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dcbang for more book information.
#---
class JasmineDev < Thor

  desc 'release_prep', "Update version and build distributions"
  def release_prep
    say JasmineDev.spacer

    say "Building Release...", :cyan

    return unless pages_submodule_installed?

    invoke :write_version_files
    invoke :build_distribution
    invoke :build_standalone_distribution
    invoke :build_github_pages
  end
end