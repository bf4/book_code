task :run_webpack_in_test_env do
  unless ENV["SKIP_WEBPACK"] == 'true'
    system({ "RAILS_ENV" => "test"}, "bin/webpack")
  end
end
task :spec => :run_webpack_in_test_env
