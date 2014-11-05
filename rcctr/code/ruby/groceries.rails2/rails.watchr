# Run me with:
#
#   $ watchr specs.watchr

# --------------------------------------------------
# Watchr Rules
# --------------------------------------------------
watch('config/routes.rb') { system("clear; rake routes")}
#START:SPECS
watch('^spec/(.*)_spec\.rb') { |m| run_test_matching(m[1]) }
watch('^app/(.*)\.rb') { |m| run_test_matching(m[1]) }
#END:SPECS
watch('^app/(.*)\.haml') { |m| run_test_matching(m[1]) }
#START:MIGRATION
watch('^db/migrate/(.*)\.rb') { |m| check_migration(m[1]) }
#END:MIGRATION
watch('^spec/spec_helper\.rb') { run_all_tests }
watch('^spec/factories/.*\.rb') { run_all_tests }
watch('^app/views/layouts/.*\.haml') { run_all_tests }

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
def run_test_matching(thing_to_match)
  matches = all_specs.grep(/#{thing_to_match}/i)
  run matches.join(' ') unless matches.empty?
end

#END:SPECS

#START:ALL_TESTS
def all_specs
  Dir['spec/**/*_spec.rb']
end

def run_all_tests
  @all_tests_passing = run(all_specs.join(' '))
end

def run_test_matching(thing_to_match)
  matches = all_specs.grep(/#{thing_to_match}/i)
  if !matches.empty? && run(matches.join(' '))
    run_all_tests unless @all_tests_pass
  end
end

#START:SPECS
def run(files_to_run)
  puts("Running: #{files_to_run}")
  system("clear;spec -cfs #{files_to_run}")
end
#END:SPECS
#END:ALL_TESTS

#START:SASS
def check_sass(sass_file)
  system("clear; compass compile public/stylesheets/sass/#{sass_file}")
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

#START:SASS
watch('^public/stylesheets/sass/(.*\.sass)') { |m| check_sass(m[1]) }
#END:SASS

# vim:ft=ruby
