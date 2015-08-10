#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dcbang for more book information.
#---
class JasmineDev < Thor

  desc "js_hint", "Run Jasmine source through JSHint"
  def js_hint
    say JasmineDev.spacer

    return unless node_installed?

    say "Running JSHint on Jasmine source and specs...", :cyan

    run_with_output "node jshint/run.js", :capture => true
  end
end