require 'bundler/capistrano'

set :application, "free_candy"
set :repository,  "https://github.com/dbcfoxes2014/free_candy"
set :deploy_to, "/var/www/#{application}"
set :scm, :git
set :branch, "master"
set :user, "deployer"
set :group, "deployers"
set :rails_env, "production"
set :deploy_via, :copy
set :ssh_options, { :forward_agent => true, :port => 1026 }
set :keep_releases, 5
default_run_options[:pty] = true
server "107.170.118.223", :app, :web, :db, :primary => true

namespace :deploy do
	task :start do ; end
	task :stop do ; end

	desc "Symlink shared config files"
	task :symlink_config_files do
		run "#{ try_sudo } ln -s #{ deploy_to }/shared/config/database.yml #{ current_path }/config/database.yml && #{ try_sudo } ln -s #{ deploy_to }/shared/config/instagram.yml #{ current_path }/config/instagram.yml"
	end
  
  desc "Precompile assets after deploy"
  task :precompile_assets do
  	run <<-CMD
  	  cd #{ current_path } &&
  	  #{ sudo } bundle exec rake assets:precompile RAILS_ENV=#{ rails_env }
  	CMD
  end

	desc "Restart Passenger app"
	task :restart do
		run "#{ try_sudo } touch #{ File.join(current_path, 'tmp', 'restart.txt') }"
  end
end

after "deploy", "deploy:symlink_config_files"
after "deploy", "deploy:restart"
after "deploy", "deploy:cleanup"