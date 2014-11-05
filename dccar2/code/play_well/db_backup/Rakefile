require 'bundler'
require 'cucumber'
require 'cucumber/rake/task'
require 'rake/clean'

Bundler::GemHelper.install_tasks

CUKE_RESULTS = 'results.html'
CLEAN << CUKE_RESULTS
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format html -o #{CUKE_RESULTS} --format progress -x"
  t.fork = false
end
