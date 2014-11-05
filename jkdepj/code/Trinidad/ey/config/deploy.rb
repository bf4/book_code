#---
# Excerpted from "Deploying with JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jkdepj for more book information.
#---
require 'bundler/capistrano'

server "localhost", :app, :db, :primary => true

ssh_options[:port] = 2222
ssh_options[:keys] = "~/.vagrant.d/insecure_private_key"

set :user, "vagrant"
set :group, "vagrant"
set :use_sudo, false

set :deploy_to, "/opt/trinidad"
set :application, "twitalytics"
set :repository, "."
set :scm, :none
set :deploy_via, :copy
set :copy_exclude, [".git","log","tmp","*.box","*.war",".idea",".DS_Store"]

set :default_environment, 
  'PATH' => "/opt/jruby/bin:$PATH", 
  'JSVC_ARGS_EXTRA' => "-user vagrant"
set :bundle_dir, ""
set :bundle_flags, "--system --quiet"

before "deploy:setup", "deploy:install_bundler"

namespace :deploy do
  task :install_bundler, :roles => :app do
    run "sudo gem install bundler"
  end

  task :start, :roles => :app do
    run "/etc/init.d/trinidad start"
  end

  task :stop, :roles => :app do end

  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
end
