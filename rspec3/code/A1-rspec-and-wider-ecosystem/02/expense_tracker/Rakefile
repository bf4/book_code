# START: basic_spec_task
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
# END: basic_spec_task

# START: spec_unit_task
require 'rspec/core/rake_task'

namespace :spec do
  desc 'Runs unit specs'
  RSpec::Core::RakeTask.new(:unit) do |t|
    t.pattern = 'spec/unit/**/*_spec.rb'
    t.rspec_opts = ['--profile']
  end
end
# END: spec_unit_task

# START: spec_task_with_rescue
begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  puts 'Spec tasks not defined since RSpec is unavailable'
end
# END: spec_task_with_rescue
