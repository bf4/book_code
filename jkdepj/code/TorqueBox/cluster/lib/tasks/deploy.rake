# START:stage
namespace :deploy do
  task :knob do
    ENV["exclude"] = "puppet,.box,.war,.sqlite3"
    Rake::Task["torquebox:remote:stage"].invoke
    # END:stage
    # START:db_migrate
    Rake::Task["torquebox:remote:exec"].
       invoke("bundle exec rake db:migrate")
    puts "Migrations Complete..."
    # END:db_migrate
    # START:stage_deploy
    Rake::Task["torquebox:remote:stage:deploy"].invoke
    # END:stage_deploy
    puts "Deployment Complete!"
    # START:stage
  end
end
# END:stage