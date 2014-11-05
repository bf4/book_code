# Run me with:
#
#   $ watchr specs.watchr

# --------------------------------------------------
# Watchr Rules
# --------------------------------------------------

#START:SPECS
watch('^spec/(.*)_spec\.rb') { |m| run_test_matching(m[1]) }
watch('^app/(.*)\.rb') { |m| run_test_matching(m[1]) }
#END:SPECS

#START:MIGRATION
watch('^db/migrate/(.*)\.rb') { |m| check_migration(m[1]) }
#END:MIGRATION

#START:ALL_TESTS
watch('^spec/spec_helper\.rb') { run_all_tests }
#END:ALL_TESTS

#START:JSLINT
watch('^(public/javascripts/(.*)\.js)') do |m| 
  jslint_check("#{m[1]}")
end

watch('^(spec/javascripts/(.*)\.js)') do |m| 
  jslint_check("#{m[1]}")
end

#END:JSLINT

#START:JASMINE-WATCH
watch('^(public/javascripts/(.*)\.js)') { |m| run_specs }
watch('^(spec/javascripts/(.*)\.js)') { |m| run_specs }

#END:JASMINE-WATCH

#START:MERGED
watch('^(public/javascripts/(.*)\.js)') { |m| check_js("#{m[1]}") }
watch('^(spec/javascripts/(.*)\.js)') { |m| check_js("#{m[1]}") }

#END:MERGED
#
# --------------------------------------------------
# Convenience Methods
# --------------------------------------------------

#START:MERGED
def check_js(file_to_check)
  run_specs if jslint_check(file_to_check)
end

#START:JSLINT
def jslint_check(files_to_check)
  system('clear')
  puts "Checking #{files_to_check}"
  system("jslint #{files_to_check}")
end
#END:JSLINT

#START:JASMINE-METHOD
def run_specs
  system('clear')
  load_path = "vendor/js/jasmine-node/lib:spec/javascripts:public/javascripts"
  system("env NODE_PATH=#{load_path} node vendor/js/jasmine-node/specs.js")
end
#END:JASMINE-METHOD
#END:MERGED

#START:SPECS
def all_specs
  Dir['spec/**/*_spec.rb']
end

def run_test_matching(thing_to_match)
  matches = all_specs.grep(/#{thing_to_match}/i)
  run matches.join(' ') unless matches.empty?
end

def run(files_to_run)
  system("clear;rspec --drb #{files_to_run}")
end
#END:SPECS

#START:ALL_TESTS
def run_all_tests
  @all_tests_passing = run(all_specs.join(' '))
  puts 'All tests pass' if @all_tests_passing
end

def run_test_matching(thing_to_match)
  matches = all_specs.grep(/#{thing_to_match}/i)
  if matches.any?
    @all_tests_passing &= run(matches.join(' '))
    run_all_tests unless @all_tests_passing
  end
end

#END:ALL_TESTS

#START:SASS
watch('^public/stylesheets/sass/(.*\.sass)') { |m| check_sass(m[1]) }

def check_sass(sass_file)
  system("clear; sass --check public/stylesheets/sass/#{sass_file}")
end
#END:SASS

#START:MIGRATION
def check_migration migration_file
  system("clear; rake db:migrate:reset")
end
#END:MIGRATION

#START:MIGRATION-SPECS
watch('^db/migrate/\d*_create_(.*)\.rb') { |m| check_migration(m[1]) }

def check_migration migration_file
  system("clear; rake db:migrate:reset")
  run_test_matching(migration_file)
end
#END:MIGRATION-SPECS

# vim:ft=ruby
