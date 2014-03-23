
set :application, 'free_candy'
set :user, "deployer"
set :deploy_to, "/home/deployer/free_candy"
set :deploy_via, :copy
set :use_sudo, false
set :scm, :git
set :repository, "git@github.com:dbcfoxes2014/free_candy.git"
set :branch, "master"
default_run_options[:pty] = true
set :ssh_options, { :forward_agent => true, :port => 1026 }

set :rails_env, "production"

set :keep_releases, 5
after "deploy", "deploy:cleanup" # keep only the last 5 releases

server '107.170.118.223', :web, :app, :db, :primary => true