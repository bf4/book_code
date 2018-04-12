desc "Run unit tests of JavaScript code with Karma"
task :karma do
  ENV["NODE_ENV"] = "test"
  mkdir_p "spec/fake_root"
  sh("$(yarn bin)/karma start spec/javascript/karma.conf.js " +
     "--single-run --log-level=error --fail-on-empty-test-suite")
end
task :default => :karma
