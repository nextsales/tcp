require 'bundler/capistrano'

require 'bundler/capistrano'
$:.unshift(File.expand_path("./lib", ENV["rvm_path"]))
require 'rvm/capistrano'

default_run_options[:shell] = 'bash'
set :rvm_ruby_string, "ruby-1.9.3-p429"
set :rvm_type, :user
set :bundle_cmd, 'source $HOME/.bash_profile && bundle'

set :application, "TopCompetitors Dashboard"
set :repository,  "git@github.com:nextsales/tcp.git"
set :deploy_to, "/home/deployer/topcompetitors/rails"
set :scm, :git
set :branch, "master"
set :user, "deployer"
set :group, "deployers"
set :use_sudo, false
set :rails_env, "production"
set :deploy_via, :copy
set :ssh_options, { :forward_agent => true, :port => 4321 }
set :keep_releases, 5
default_run_options[:pty] = true
server "dashboard.topcompetitors.net", :app, :web, :db, :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end

  desc "Symlink shared config files"
  task :symlink_config_files do
    run "#{ sudo } ln -s #{ deploy_to }/shared/config/database.yml #{ current_path }/config/database.yml"
  end

  # NOTE: I don't use this anymore, but this is how I used to do it.
  desc "Precompile assets after deploy"
  task :precompile_assets do
    run <<-CMD
      cd #{ current_path } &&
      #{ sudo } bundle exec rake assets:precompile RAILS_ENV=#{ rails_env }
    CMD
  end

  desc "Restart applicaiton"
  task :restart do
    run "#{ try_sudo } touch #{ File.join(current_path, 'tmp', 'restart.txt') }"
  end
end

after "deploy", "deploy:symlink_config_files"
after "deploy", "deploy:restart"
after "deploy", "deploy:cleanup"
