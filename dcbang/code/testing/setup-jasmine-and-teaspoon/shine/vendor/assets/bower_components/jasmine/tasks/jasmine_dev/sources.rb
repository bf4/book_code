#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dcbang for more book information.
#---
class JasmineDev < Thor
  JASMINE_SOURCES = {
    :core => [
      "base.js",
      "util.js",
      "Env.js",
      "Reporter.js",
      "Block.js",
      "JsApiReporter.js",
      "Matchers.js",
      "mock-timeout.js",
      "MultiReporter.js",
      "NestedResults.js",
      "PrettyPrinter.js",
      "Queue.js",
      "Runner.js",
      "Spec.js",
      "Suite.js",
      "WaitsBlock.js",
      "WaitsForBlock.js"
    ],

    :html => [
      "HtmlReporterHelpers.js",
      "HtmlReporter.js",
      "ReporterView.js",
      "SpecView.js",
      "SuiteView.js",
      "TrivialReporter.js"
    ]
  }
end
