def passing_specs
  Dir['spec/**/*_spec.rb']
end

def failing_specs
  Dir['spec/**/*_spec_fail.rb']
end

def run_passing_specs
  passing_specs.find do |f|
    system("rspec -fs #{f}") == false
  end.nil?
end

def run_failing_specs
  failing_specs.find do |f|
    system("rspec -fs #{f} > /dev/null") 
  end.nil?
end

def run_all_tests
  system('clear')
  run_failing_specs if run_passing_specs
end

watch('^spec/(.*)_spec\.rb'  )   { |m| run_all_tests }
watch('^lib/(.*)\.rb'               )   { |m| run_all_tests }
watch('^spec/spec_helper\.rb')   { run_all_tests }

# vim:ft=ruby
