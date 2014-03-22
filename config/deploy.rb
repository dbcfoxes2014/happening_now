set :application, 'FreeCandy'
set :repository, "git@github.com:dbcfoxes2014/free_candy.git"
set :deploy_to, "/home/rails"
set :scm, "git"
set :branch, "master"
set :user, "joe"
set :use_sudo, false
set :rails_env, "production"
set :deploy_via, :copy
set :ssh_options, { :forward_agent => true, :port => 22 }
set :keep_releases, 5
default_run_options[:pty] = true
server '107.170.118.223', :web, :app, :db, :primary => true