set :application, "free_candy"
set :repository,  "https://github.com/dbcfoxes2014/free_candy"

set :deploy_to, "/var/www/default"
set :scm, :git
set :branch, "master"

set :user, "deployer"
set :use_sudo, false

set :rails_env, "production"

set :deploy_via, :copy

set :ssh_options, { :forward_agent => true, :port => 1026 }

set :keep_releases, 5

default_run_options[:pty] = true

server "107.170.118.223", :app, :web, :db, :primary => true

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end